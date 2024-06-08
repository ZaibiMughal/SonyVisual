<?php

namespace backend\modules\api\controllers;

use common\models\User;
use common\models\VideoFavorite;
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
class VideoFavoriteController extends BaseController
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
        $data = [];
        try {
        if($user_id){
                $user = User::findOne(['id' => $user_id]);
                if (!empty($user)) {
                    $videos = $user->getFavoriteVideos();
                    foreach ($videos as $video) {
                        $data[] = $video->toMap();
                    }
                    Yii::$app->response->statusCode = 200;
                    return [
                        'status' => true,
                        'data' => [
                            'videoPosts' => $data
                        ],
                        'messages' => count($videos) > 0 ? ['Success'] : ['No Videos found!']
                    ];
                }

        } else {
            $videos = VideoPost::find()->orderBy('id desc')->all();
            foreach ($videos as $video) {
                $data[] = $video->toMap();
            }
            Yii::$app->response->statusCode = 200;
            return [
                'status' => true,
                'data' => [
                    'videoPosts' => $data
                ],
                'messages' => count($videos) > 0 ? ['Success'] : ['No Videos found!']
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
            'messages' => ['No Videos found!']
        ];
    }

    public function actionCreate()
    {
        $video_id = Yii::$app->request->get('video_id','');
        $user_id = Yii::$app->request->get('user_id','');
        $is_favorite = Yii::$app->request->get('is_favorite',0);

        $model = VideoFavorite::findOne(['video_id' => $video_id, 'user_id' => $user_id]) ?? new VideoFavorite();

        $model->video_id = $video_id;
        $model->user_id = $user_id;

        try {
            if ($model->validate()) {

                if($is_favorite){
                    $model->save();
                } else {
                    return $this->actionDelete();
                }
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

    public function actionDelete()
    {
        $message = "";
        $data = "";
        $status = false;
        $video_id = Yii::$app->request->get('video_id','');
        $user_id = Yii::$app->request->get('user_id','');

        try{
            $model = VideoFavorite::findOne(['video_id' => $video_id, 'user_id' => $user_id]);
            if($model){
                $model->delete();
                Yii::$app->response->statusCode = 200;
                $status = true;
            } else {
                $status = true;
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
