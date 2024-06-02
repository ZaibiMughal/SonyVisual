<?php

namespace backend\controllers;

use common\models\ChangePasswordForm;
use common\models\ReportAuth;
use common\models\User;
use common\models\UserSearch;
use yii\base\Exception;
use yii\base\Model;
use yii\filters\AccessControl;
use yii\web\Controller;
use yii\web\NotFoundHttpException;
use yii\filters\VerbFilter;

/**
 * UserController implements the CRUD actions for User model.
 */
class UserController extends Controller
{
    /**
     * @inheritDoc
     */
    public function behaviors()
    {
        return array_merge(
            parent::behaviors(),
            [
                'access' => [
                    'class' => AccessControl::class,
                    'rules' => [
                        [
                            'allow' => true,
                            'roles' => ['@'],
                        ],
                    ],
                ],
                'verbs' => [
                    'class' => VerbFilter::className(),
                    'actions' => [
                        'create' => ['GET', 'POST'],
                        'update' => ['GET', 'PUT', 'POST'],
                        'delete' => ['POST', 'DELETE'],
                        '*' => ['GET','POST'],
                    ],
                ],
            ]
        );
    }

    /**
     * Lists all User models.
     *
     * @return string
     */
    public function actionIndex()
    {
        $searchModel = new UserSearch();
        $dataProvider = $searchModel->search($this->request->queryParams);

        return $this->render('index', [
            'searchModel' => $searchModel,
            'dataProvider' => $dataProvider,
        ]);
    }

    /**
     * Displays a single User model.
     * @param int $id ID
     * @return string
     * @throws NotFoundHttpException if the model cannot be found
     */
    public function actionView($id)
    {
        return $this->render('view', [
            'model' => $this->findModel($id),
        ]);
    }

    /**
     * Creates a new User model.
     * If creation is successful, the browser will be redirected to the 'view' page.
     * @return string|\yii\web\Response
     */
    public function actionCreate()
    {
        $model = new User(['scenario' => 'register']);
        $model->updated_by = \Yii::$app->user->id;

        if ($this->request->isPost) {
            if ($model->load($this->request->post())) {
                $model->generateHiddenAttributes();
                $model->updated_at = time();

                if($model->validate() &&  $model->save()){
                    return $this->redirect(['view', 'id' => $model->id]);
                } else {
                    \Yii::$app->session->setFlash('alert_error', $model->getErrorSummary(true));
                }
            }

        } else {
            $model->loadDefaultValues();
        }

        return $this->render('create', [
            'model' => $model,
        ]);
    }

    /**
     * Updates an existing User model.
     * If update is successful, the browser will be redirected to the 'view' page.
     * @param int $id ID
     * @return string|\yii\web\Response
     * @throws NotFoundHttpException if the model cannot be found
     */
    public function actionUpdate($id)
    {
        $model = $this->findModel($id);
        $old_model = clone $model;

        if ($this->request->isPost && $model->load($this->request->post())) {
            $password = isset($_POST['User']['password']) ? trim($_POST['User']['password']) : "";
            if($password){
                $model->setPassword($password);
            }
            if(!empty($model->password)){
                $model->setPassword($model->password);
            }
            $is_same = User::isSameObject($model,$old_model);

            if(!$is_same){
//                $model->updated_by = \Yii::$app->user->id;
                $model->updated_at = time();
            }

            if($model->validate()){
                $model->save();
            } else {
                \Yii::$app->session->setFlash('alert_error', $model->getErrorSummary(true));
            }
            return $this->redirect(['view', 'id' => $model->id]);
        }

        return $this->render('update', [
            'model' => $model,
        ]);
    }

    /**
     * Deletes an existing User model.
     * If deletion is successful, the browser will be redirected to the 'index' page.
     * @param int $id ID
     * @return \yii\web\Response
     * @throws NotFoundHttpException if the model cannot be found
     */
    public function actionDelete($id)
    {
        try{
            $model = $this->findModel($id);
            if($model){
                if($model->isSuperAdmin()){
                    $message = "Can't delete the Super Admin";
                    \Yii::$app->session->setFlash('alert_error', [$message]);
                } else {
                    $this->findModel($id)->delete();
                }
            }
        } catch (\yii\base\Exception $e){
            $message = "Can't delete this record as it is being referenced in other Data / Table";
            \Yii::$app->session->setFlash('alert_error', [$message]);
        }

        return $this->redirect(['index']);
    }

    /**
     * Finds the User model based on its primary key value.
     * If the model is not found, a 404 HTTP exception will be thrown.
     * @param int $id ID
     * @return User the loaded model
     * @throws NotFoundHttpException if the model cannot be found
     */
    protected function findModel($id)
    {
        if (($model = User::findOne(['id' => $id])) !== null) {
            return $model;
        }

        throw new NotFoundHttpException('The requested page does not exist.');
    }

    public function actionChangePassword(){
        $model = \Yii::$app->user->identity;
        $change_password_form = new ChangePasswordForm();

        if($model && $change_password_form->load(\Yii::$app->request->post()) && $change_password_form->changePassword($model)){
            \Yii::$app->session->setFlash('alert_success', ["Password changed successfully!"]);
            $change_password_form->password = "";
            $change_password_form->new_password = "";
            $change_password_form->confirm_password = "";
        }

        return $this->render('change_password', [
            'model' => $change_password_form,
        ]);
    }
}
