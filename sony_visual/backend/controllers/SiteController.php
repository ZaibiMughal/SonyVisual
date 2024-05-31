<?php

namespace backend\controllers;

use Cassandra\Custom;
use common\models\Backup;
use common\models\Country;
use common\models\Customer;
use common\models\LoginForm;
use common\models\PaymentType;
use common\models\Product;
use common\models\ProductBooking;
use common\models\ReportAuth;
use common\models\SaleReport;
use frontend\models\SignupForm;
use Yii;
use yii\filters\VerbFilter;
use yii\filters\AccessControl;
use yii\web\Controller;
use yii\web\Cookie;
use yii\web\Response;

/**
 * Site controller
 */
class SiteController extends Controller
{

    public $is_authorized = false;
    /**
     * {@inheritdoc}
     */
    public function behaviors()
    {
        return [
            'access' => [
                'class' => AccessControl::className(),
//                'only' => ['login', 'logout','index'],
                'rules' => [
                    [
                        'actions' => ['login', 'error','signup','privacy-policy','contact-us'],
                        'allow' => true,
                        'roles' => ['?'] // ? => Guest User
                    ],
                    [
//                        'actions' => ['logout', 'index','report'],
                        'allow' => true,
                        'roles' => ['@'],
                    ],
//                    [
//                        'actions' => ['report', 'sale-report'],
////                        'allow' => true,
//                        'roles' => array('allowOnlyOwner')
//                    ],
                ],
            ],
            'verbs' => [
                'class' => VerbFilter::className(),
                'actions' => [
                    'logout' => ['post'],
                ],
            ],
        ];
    }


    /**
     * {@inheritdoc}
     */
    public function actions()
    {
        return [
            'error' => [
                'class' => 'yii\web\ErrorAction',
            ],
        ];
    }

    public function allowOnlyOwner(){
        if(Yii::$app->user->identity->isMasterUser()){
            return true;
        }
        return false;
    }

    /**
     * Displays homepage.
     *
     * @return string
     */
    public $data = [];
    public function actionIndex()
    {

        $today_start = date('Y-m-d 00:00:00', time());
        $today_end = date('Y-m-d 23:59:59', time());

        $week_start = date('Y-m-d 00:00:00', strtotime('-1 week'));
        $week_end = date('Y-m-d 23:59:59', strtotime('-1 day'));

        $month_start = date('Y-m-01 00:00:00', time());
        $month_end = date('Y-m-t 23:59:59', time());

        $reportModules = [
            'User',
            'VideoPost'
        ];

        foreach ($reportModules as $module){
            $this->data['today'][$module] = call_user_func(["common\\models\\$module",'getReportByDate'],$today_start, $today_end);
            $this->data['week'][$module] = call_user_func(["common\\models\\$module",'getReportByDate'],$week_start, $week_end);
            $this->data['month'][$module] = call_user_func(["common\\models\\$module",'getReportByDate'],$month_start, $month_end);
            $this->data['all'][$module] = call_user_func(["common\\models\\$module",'getReportByDate'],'', '');
        }

        return $this->render('index',['data' => $this->data, 'modules' => $reportModules]);
    }

    /**
     * Login action.
     *
     * @return string|Response
     */
    public function actionLogin()
    {
        if (!Yii::$app->user->isGuest) {
            return $this->goHome();
        }

        $this->layout = 'blank';

        $model = new LoginForm();

        if ($model->load(Yii::$app->request->post()) && $model->login()) {
            return $this->redirect("index");
        }

        $model->password = '';

        return $this->render('login', [
            'model' => $model,
        ]);
    }

    /**
     * Logout action.
     *
     * @return Response
     */
    public function actionLogout()
    {
        Yii::$app->user->logout();

        return $this->redirect("login");
    }

    public function actionPrivacyPolicy(){
        $this->view->title = "Privacy Policy";

//        $this->layout = '@frontend/views/layouts/main';
        $this->layout = '@backend/views/layouts/custom';
        return $this->render('privacy');
    }

    public function actionContactUs(){
        $this->view->title = "Contact Us";
        $this->layout = '@backend/views/layouts/custom';
        return $this->render('contact-us');
    }
}
