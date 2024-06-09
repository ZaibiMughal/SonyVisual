<?php

namespace common\models;

use Yii;

/**
 * This is the model class for table "video_post".
 *
 * @property int $id
 * @property int $user_id
 * @property string $title
 * @property string $description
 * @property string $url
 * @property int $privacy
 * @property string|null $category
 * @property string|null $created
 *
 * @property User $user
 */
class VideoPost extends \yii\db\ActiveRecord
{
    public User $user;
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'video_post';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['user_id', 'title', 'description', 'url'], 'required'],
            [['user_id', 'privacy'], 'integer'],
            [['created'], 'safe'],
            [['title'], 'string', 'max' => 255],
            [['description', 'url', 'category'], 'string', 'max' => 1000],
            ['url', 'match', 'pattern' => '/^(?:https?:\/\/)?(?:www\.)?(?:youtube\.com\/(?:watch\?v=|embed\/|v\/|shorts\/|.*[?&]v=)|youtu\.be\/)([a-zA-Z0-9_-]{11})/', 'message' => 'The URL must be a valid YouTube URL.'],
            [['user_id'], 'exist', 'skipOnError' => true, 'targetClass' => User::class, 'targetAttribute' => ['user_id' => 'id']],
            ['url','validatePost'],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'user_id' => 'User',
            'title' => 'Title',
            'description' => 'Description',
            'url' => 'Url',
            'privacy' => 'Privacy',
            'category' => 'Category',
            'created' => 'Created',
        ];
    }


    public function validatePost($attribute, $params)
    {
        $post = VideoPost::findOne([
            'user_id' => $this->user_id,
            'url' => $this->$attribute
        ]);
        if (!empty($post)) {
            $this->addError($attribute, 'Post already exist');
        }
    }


    /**
     * Gets query for [[User]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getUserRelation()
    {
        return $this->hasOne(User::class, ['id' => 'user_id']);
    }

    public function getUser(): ?User
    {
        if(!empty($this->user))
            return $this->user;
        return $this->user = User::findOne(['id' => $this->user_id]);
    }
    public function getUserName(): string
    {
        $user = $this->getUser();
        return is_null($user) ? "Unknown" : $user->getName();
    }


    public function getUserThumbnail(): string
    {
        $user = $this->getUser();
        return is_null($user) ? "https://admin.sonyvisual.com/images/logo.png" : $user->getThumbnail();
    }

    public function getVideoId(){

        $pattern = '/^(?:https?:\/\/)?(?:www\.)?(?:youtube\.com\/(?:watch\?v=|embed\/|v\/|shorts\/|.*[?&]v=)|youtu\.be\/)([a-zA-Z0-9_-]{11})/';

        // Perform the regex match
        if (preg_match($pattern, $this->url, $matches)) {
            return $matches[1];
        }
        return null;
    }

    public function getThumbnail(){
        $id = $this->getVideoId();
        return empty($id) ? "https://admin.sonyvisual.com/images/logo.png" : "https://img.youtube.com/vi/$id/0.jpg";
    }

    public function toMap($currentUserId = 0){
        $totalLikes = VideoFavorite::find()->where(['video_id' => $this->id])->count();

        $arr = [
            'id' => $this->id,
            'title' => $this->description,
            'description' => $this->description,
            'user_id' => $this->user_id,
            'user_thumbnail' => $this->getUserThumbnail(),
            'username' => $this->getUserName(),
            'privacy' => $this->privacy,
            'url' => $this->url,
            'thumbnail' => $this->getThumbnail(),
            'category' => $this->category,
            'total_likes' => $totalLikes,

        ];

        if($currentUserId){
            $isFavoriteVideo = VideoFavorite::findOne(['video_id' => $this->id, 'user_id' => $currentUserId]);
        }

        return array_merge($arr,[
            'is_favorite' => empty($isFavoriteVideo) ? 0 : 1,
        ]);
    }

    public static function getReport($month){
        $start_created = date('Y-m-01 00:00:00', (int)$month);
        $end_created = date('Y-m-t 23:59:59', (int)$month);

        $query = VideoPost::find()
            ->where([
                '>=',
                'created', $start_created
            ])
            ->andWhere([
                '<=',
                'created',
                $end_created,
            ]);

        $count = $query->count();



        return isset($count) ? $count : 0;
    }

    public static function getReportByDate($startTime, $endTime){

        $query = VideoPost::find();
        if(!empty($startTime)) {
            $query->where([
                '>=',
                'created', $startTime
            ]);
        }
        if(!empty($endTime)) {
            $query->andWhere([
                '<=',
                'created',
                $endTime,
            ]);
        }

        $count = $query->count();



        return isset($count) ? $count : 0;
    }
}
