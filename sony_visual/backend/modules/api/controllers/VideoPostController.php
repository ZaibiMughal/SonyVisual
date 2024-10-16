<?php

namespace backend\modules\api\controllers;

use common\models\Event;
use common\models\User;
use common\models\VideoPost;
use Yii;
use yii\base\Exception;
use yii\filters\auth\HttpBasicAuth;
use yii\filters\VerbFilter;
use yii\web\Controller;
use yii\web\Response;

/**
 * Default controller for the `api` module
 */
class VideoPostController extends BaseController
{
    /**
     * Renders the index view for the module
     * @return array[]
     */

    public function behaviors()
    {
        $behaviors = parent::behaviors();
        $behaviors['authenticator'] = [
            'class' => HttpBasicAuth::class,
            'auth' => function ($username, $password) {
            if($username == User::APP_USERNAME && $password == User::APP_PASSWORD){
                return User::find()->one();
            }
            return null;
        }
        ];
        $behaviors['verbs'] = [
            'class' => VerbFilter::className(),
            'actions' => [
                'create' => ['GET','POST'],
                'view' => ['GET'],
                'update' => ['GET','POST'],
                'delete' => ['GET','POST'],
                '*' => ['GET'],
            ],
        ];
        return $behaviors;
    }

    public function actionIndex()
    {
        $user_id = \Yii::$app->request->get('user_id',0);
        $current_user_id = \Yii::$app->request->get('current_user_id',0);

        $data = [];
        try {
        if($user_id){
                $user = User::findOne(['id' => $user_id]);
                if (!empty($user)) {
                    $videos = $user->getVideos();
                    foreach ($videos as $video) {
                        $data[] = $video->toMap($current_user_id);
                    }
                    Yii::$app->response->statusCode = 200;
                    return [
                        'status' => true,
                        'data' => [
                            'videoPosts' => $data
                        ],
                        'messages' => count($videos) > 0 ? ['Success'] : ['No Video Posts found!']
                    ];
                }

        } else {
            $videos = VideoPost::find()->orderBy('id desc')->all();
            foreach ($videos as $video) {
                $data[] = $video->toMap($current_user_id);
            }
            Yii::$app->response->statusCode = 200;
            return [
                'status' => true,
                'data' => [
                    'videoPosts' => $data
                ],
                'messages' => count($videos) > 0 ? ['Success'] : ['No Video Posts found!']
            ];
        }

        } catch (Exception $e){
        Yii::$app->response->statusCode = 500;
        return [
            'status' => false,
            'data' => null,
            'messages' => ['Something went wrong!']
        ];
    }
        Yii::$app->response->statusCode = 422;
        return [
            'status' => false,
            'data' => null,
            'messages' => ['No Video Posts found!']
        ];
    }

    public function actionCreate()
    {
        $title = Yii::$app->request->get('title','');
        $desc = Yii::$app->request->get('description','');
        $url = Yii::$app->request->get('url','');
        $user_id = Yii::$app->request->get('user_id','');

        $model = new VideoPost();

        $model->title = $title;
        $model->description = $desc;
        $model->url = $url;
        $model->user_id = $user_id;

        try {
            if ($model->validate()) {
                $model->save();
                Yii::$app->response->statusCode = 201;
                return [
                    'status' => true,
                    'data' => $model,
                    'messages' => ['Success']
                ];
            } else {
                Yii::$app->response->statusCode = 422;
                return [
                    'status' => false,
                    'data' => null,
                    'messages' => $model->getErrorSummary(true)
                ];
            }

        } catch (\Exception $e){
            Yii::$app->response->statusCode = 500;
            return [
                'status' => false,
                'data' => null,
                'messages' => ['Something went wrong!']
            ];
        }
    }

    public function actionUpdate()
    {
        $id = Yii::$app->request->get('id','');
        $title = Yii::$app->request->get('title','');
        $desc = Yii::$app->request->get('description','');

        try {
        $model = VideoPost::findOne($id);

        $model->title = $title;
        $model->description = $desc;

        if($model) {
            if ($model->validate()) {
                $model->save();
                Yii::$app->response->statusCode = 200;
                return [
                    'status' => true,
                    'data' => $model,
                    'messages' => ['Success']
                ];
            } else {
                Yii::$app->response->statusCode = 422;
                return [
                    'status' => false,
                    'data' => null,
                    'messages' => $model->getErrorSummary(true)
                ];
            }
        } else {
            Yii::$app->response->statusCode = 404;
            return [
                'status' => false,
                'data' => null,
                'messages' => ['Post not found!']
            ];
        }

        } catch (\Exception $e){
            Yii::$app->response->statusCode = 500;
            return [
                'status' => false,
                'data' => null,
                'messages' => ['Something went wrong!']
            ];
        }
    }

    public function actionDelete()
    {
        $message = "";
        $data = "";
        $status = false;
        $id = Yii::$app->request->get('id',0);
        $user_id = Yii::$app->request->get('user_id',0);
        try{
            $model = VideoPost::findOne(['id' => $id, 'user_id' => $user_id]);
            if($model){
                $model->delete();
                Yii::$app->response->statusCode = 200;
                $status = true;
            } else {
                $message = "Post not found";
                Yii::$app->response->statusCode = 404;
            }
        } catch (\yii\base\Exception $e){
            $message = "Something went wrong!";
            Yii::$app->response->statusCode = 422;
        }

        return [
            'status' => $status,
            'data' => null,
            'messages' => [$message]
        ];
    }
}
