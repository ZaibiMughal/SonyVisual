<?php

namespace common\models;

use yii\base\Model;
use yii\data\ActiveDataProvider;
use common\models\User;

/**
 * UserSearch represents the model behind the search form of `common\models\User`.
 */
class UserSearch extends User
{
    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['id', 'status','user_type','updated_by'], 'integer'],
            [['full_name', 'cell_phone', 'auth_key', 'password_hash', 'password_reset_token', 'email', 'verification_token', 'created_at', 'updated_at'], 'safe'],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function scenarios()
    {
        // bypass scenarios() implementation in the parent class
        return Model::scenarios();
    }

    /**
     * Creates data provider instance with search query applied
     *
     * @param array $params
     *
     * @return ActiveDataProvider
     */
    public function search($params)
    {
        $query = User::find();

        $query->innerJoinWith(['userTypeRelation']);

        $query->where([
//            'in','user_type.name',['Employee','Manager']
            'in','user_type.name',[User::$customer,User::$admin]
        ]);

        // add conditions that should always apply here

        $dataProvider = new ActiveDataProvider([
            'query' => $query,
        ]);

        $this->load($params);

        if (!$this->validate()) {
            // uncomment the following line if you do not want to return any records when validation fails
            // $query->where('0=1');
            return $dataProvider;
        }

//        echo '<pre>';
//        print_r($this);
//        exit;
        if (!empty($this->created_at)) {
            $query->andFilterWhere([
                '>=',
                'created_at',
                date('Y-m-d 00:00:00', strtotime($this->created_at)),
            ]);
            $query->andFilterWhere([
                '<=',
                'created_at',
                date('Y-m-d 23:59:59', strtotime($this->created_at)),
            ]);
        }

        if (!empty($this->updated_at)) {
            $query->andFilterWhere([
                '>=',
                'updated_at',
                date('Y-m-d 00:00:00', strtotime($this->updated_at)),
            ]);
            $query->andFilterWhere([
                '<=',
                'updated_at',
                date('Y-m-d 23:59:59', strtotime($this->updated_at)),
            ]);
        }

//        print_r($this->updated_by);
//        exit;
        // grid filtering conditions
        $query->andFilterWhere([
            'id' => $this->id,
            'status' => $this->status,
            'user_type' => $this->user_type,
            'updated_by' => $this->updated_by,
        ]);

        $query->andFilterWhere(['like', "(first_name||' '||last_name)", $this->full_name])
            ->andFilterWhere(['like', 'email', $this->email])
            ->andFilterWhere(['like', 'cell_phone', $this->cell_phone]);
        return $dataProvider;
    }
}
