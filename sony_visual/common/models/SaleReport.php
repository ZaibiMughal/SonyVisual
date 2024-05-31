<?php

namespace common\models;

use Yii;
use yii\base\Model;
use yii\helpers\Url;

/**
 * This is the model class for table "backup".
 *
 * @property int $product_model
 * @property int $product_type
 * @property int $report_type
 * @property int $payment_type
 * @property int $company
 * @property string $start_date
 * @property string $end_date
 * @property string $password
 */
class SaleReport extends Model
{
    public $start_date;
    public $end_date;
    public $product_model;
    public $product_type;
    public $report_type;
    public $payment_type;
    public $employee;
    public $company;
    public $password;

    function __construct()
    {
        parent::__construct();
        $this->start_date = date("01-m-Y");
        $this->end_date = date("t-m-Y");
        $this->product_model = 0;
        $this->payment_type = 0;
        $this->report_type = 0;
        $this->product_type = 0;
        $this->employee = 0;
        $this->password = '';
        $this->company = 0;
    }



    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['start_date','end_date'], 'required'],
            [['product_model','report_type'], 'safe'],
            [['product_model','report_type','product_type','employee','company'], 'integer'],
            [['payment_type','password'], 'safe'],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [];
    }


}
