<?php

namespace common\models;

use Yii;

/**
 * This is the model class for table "user_type".
 *
 * @property int $id
 * @property string $name
 * @property string|null $created
 */
class UserType extends \yii\db\ActiveRecord
{
    const EMPLOYEE_ID = 1;
    const MANAGER_ID = 5;
    const SUPER_ADMIN_ID = 6;
    const CUSTOMER_ID = 4;
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'user_type';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['name'], 'required'],
            [['created'], 'safe'],
            [['name'], 'string', 'max' => 255],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'name' => 'Name',
            'created' => 'Created',
        ];
    }

    public function getFormattedDate(){
        return date('d-M-Y, h:i A', strtotime($this->created));
    }

    public function getName(){
        return $this->name;
    }

    public static function getCustomerId(){
        $object = self::find()->where(['like','LOWER(name)','customer'])->one();
        if($object){
            return $object->id;
        }
        return 1;
    }

    public static function getUserTypeArray($customer_view = false){
        $user_types = self::find()
            ->all();

        $arr = [];
        foreach ($user_types as $user){
            $arr[$user->id] = $user->getName();

//            if($customer_view){
//                if(strtolower($user->getName()) == 'customer'){
//                    $arr[$user->id] = $user->getName();
//                }
//            } else {
//                if(strtolower($user->getName()) != 'customer') {
//                    $arr[$user->id] = $user->getName();
//                }
//            }
        }
        return $arr;
    }

    public static function isSuperAdmin($id){
        return $id == self::SUPER_ADMIN_ID;
    }

    public static function isEmployee($id){
        return $id == self::EMPLOYEE_ID;
    }

    public static function isCustomer($id){
        return $id == self::CUSTOMER_ID;
    }

}
