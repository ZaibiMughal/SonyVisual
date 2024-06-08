<?php

namespace common\models;

use Yii;

/**
 * This is the model class for table "video_favorite".
 *
 * @property int $id
 * @property int $user_id
 * @property int $video_id
 * @property string|null $created
 *
 * @property SacUser $user
 * @property VideoPost $video
 */
class VideoFavorite extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'video_favorite';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['user_id', 'video_id'], 'required'],
            [['user_id', 'video_id'], 'integer'],
            [['created'], 'safe'],
            [['user_id'], 'exist', 'skipOnError' => true, 'targetClass' => User::class, 'targetAttribute' => ['user_id' => 'id']],
            [['video_id'], 'exist', 'skipOnError' => true, 'targetClass' => VideoPost::class, 'targetAttribute' => ['video_id' => 'id']],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'user_id' => 'User ID',
            'video_id' => 'Video ID',
            'created' => 'Created',
        ];
    }

    /**
     * Gets query for [[User]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getUser()
    {
        return $this->hasOne(SacUser::class, ['id' => 'user_id']);
    }

    /**
     * Gets query for [[Video]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getVideo()
    {
        return $this->hasOne(VideoPost::class, ['id' => 'video_id']);
    }

    public function getVideoModel(){
        return VideoPost::findOne(['id' => $this->video_id]);
    }

    public function toMap(){
        $model = $this->getVideoModel();
        if($model){
            return $model->toMap();
        }
        return [];
    }

}
