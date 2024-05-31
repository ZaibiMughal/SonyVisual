<?php
/* @var $this yii\web\View */
/* @var $model common\models\SaleReport */

use common\models\PaymentType;
use common\models\ProductBooking;
use common\models\ProductModel;
use common\models\ReportAuth;
use kartik\date\DatePicker;
use kartik\form\ActiveForm;
use kartik\select2\Select2;
use yii\bootstrap4\Modal;
use yii\bootstrap4\Tabs;
use yii\helpers\Html;

$this->title = Yii::t('app', 'Reports');
$product_types = (new \common\models\ProductType())->getAll();
$payment_model = isset($data['payment_model']) ? $data['payment_model'] : null;

?>


<!-- The Modal -->
<?php

$auth_exist = \common\models\ReportAuth::findOne(['user_id' => Yii::$app->user->id]);

if(!$auth_exist && Yii::$app->user->identity->isMasterUser()) { ?>
    <?= $this->render('auth_modal')?>
<?php } else {

    if(!$is_authorized){

        $formModel = new ReportAuth();
        $formModel->scenario = ReportAuth::VALIDATION_SCENARIO;

        ?>

        <div class="auth-form" style="text-align: left">

            <?php $form = ActiveForm::begin([
                'action' => '/site/sale-report',
                'fieldConfig' => [
                    'template' => "{input}\n{hint}\n{error}",
                ],
            ]); ?>

            <div class="row justify-content-center align-items-center" style="text-align: center">
                <div class="col-md-6">
                    <h1><strong>User Authentication</strong></h1>
                    <br>
                    <?= $form->field($formModel, 'password')->passwordInput(['maxlength' => 255, 'placeholder' => 'Password']) ?>
                </div>
                <div class="col-md-12">
                    <div class="form-group">
                        <?= Html::submitButton(Yii::t('app', 'Validate'), ['class' => 'btn btn-success', 'style' => 'width: 10%']) ?>
                    </div>
                </div>
            </div>
            <?php ActiveForm::end(); ?>

        </div>
    <?php
    } else {
    ?>



<div class="row">
    <div class="col-md-12">
        <div class="card border-secondary">
            <div class="card-header bg-secondary text-white">
                <h3 class="panel-title"><i class="fa fa-globe" aria-hidden="true"></i> <?= $this->title ?></h3>
            </div>
            <div class="card-body">
<!--                <div class="col-md-8">-->
<!--                    <div class="card border-secondary" style="padding: 8px">-->
<!--                        <p><strong>Sales: </strong> Total numbers of stock sold</p>-->
<!--                        <p><strong>All Sales Payment: </strong> Total price of stock sold</p>-->
<!--                        <p><strong>All Payment Spent: </strong> Total price we spent while buying stock (Price we used while creating product in model)</p>-->
<!--                        <p><strong>Cash Payment: </strong> Total payment received while selling a stock on Cash Package</p>-->
<!--                        <p><strong>Down Payment: </strong> Total down payment received while selling Stock on installments package </p>-->
<!--                        <p><strong>Installments Received: </strong> Total cash received in installments</p>-->
<!--                        <p><strong>Payment Received: </strong> Total cash received, it includes installments, down payment and complete cash(in-case of stock is sold on cash)</p>-->
<!--                        <p><strong>Payment Due: </strong> Total amount due (All Sales Payment - Total Payment Received)  </p>-->
<!--                        <p><strong>Profit: </strong> Total Profit (All Sales Payment - All Payment Spent)  </p>-->
<!--                        <br>-->
<!--                        <p style="color: darkred"><strong>IMPORTANT: Company, Product Type, and Product models filters doesn't apply on Payment spent column as it gives payment spent on orders</strong></p>-->
<!--                    </div>-->
<!--                </div>-->
<!--                <br>-->
<!--                <br>-->
                <div class="col-md-12">



                    <?php $form = ActiveForm::begin([
                        'action' => '/site/sale-report',
                        'fieldConfig' => [
                            'template' => "{input}\n{hint}\n{error}",
                        ],
                    ]); ?>
                    <div class="row">
<!--                        <div class="col-md-2">-->
<!--                            <?//= $form->field($model, 'payment_type')->dropDownList(yii\helpers\ArrayHelper::map((new PaymentType())->getAll(true), 'id', 'name')) ?>-->
<!--                        </div>-->
                        <div class="col-md-2">
<!--                            <?//= $form->field($model, 'report_type')->dropDownList(ProductBooking::getReportsType()) ?> -->
                            <?= $form->field($model, 'company')->widget(Select2::class, [
                                'data' => yii\helpers\ArrayHelper::map(\common\models\ProductCompany::find()->all(), 'id', 'name'),
                                'language' => 'en',
                                'options' => ['placeholder' => 'Select Company ...'],
                                'pluginOptions' => [
                                    'allowClear' => true
                                ],
                            ]) ?>
                        </div>
                        <div class="col-md-2">
                            <?= $form->field($model, 'product_type')->dropDownList(yii\helpers\ArrayHelper::map(\common\models\ProductType::getAll(true), 'id', 'name')) ?>
                        </div>
                        <div class="col-md-2">
                            <?= $form->field($model, 'product_model')->dropDownList(yii\helpers\ArrayHelper::map(ProductModel::getAll(true), 'id', 'name')) ?>
                        </div>


                           <div class="col-md-2">
                            <?= $form->field($model, 'employee')->widget(Select2::class, [
                                'data' => \common\models\User::getUserArray(true),
                                'language' => 'en',
                                'options' => ['placeholder' => 'Select Employee ...'],
                                'pluginOptions' => [
                                    'allowClear' => true
                                ],
                            ])  ?>
                        </div>

                        <div class="col-md-3">
                            <?= $form->field($model, 'start_date')->widget(DatePicker::classname(), [
                                'options' => ['placeholder' => Yii::t('app', 'Start Date'), 'value' => $model->start_date != null  ? $model->start_date : date('d-m-Y')],
                                'options2' => ['placeholder' => Yii::t('app', 'End Date'), 'value' => $model->end_date != null  ? $model->end_date : date('d-m-Y')],
                                'attribute2' => 'end_date',
                                'type' => DatePicker::TYPE_RANGE,
                                'pluginOptions' => [
                                    'autoclose' => true,
//                                    'startView' => 'year',
//                                    'minViewMode' => 'months',
                                    'format' => 'dd-mm-yyyy',
                                ],
                            ]) ?>
                        </div>

                        <div class="col-md-1">
                            <?= Html::submitButton(Yii::t('app', 'Filter'), ['class' => 'btn btn-success', 'style' => 'width: 100%;']) ?>
                        </div>
                    </div>


                    <?php ActiveForm::end(); ?>

                </div>

                <br>
<!--                <br>-->
                <div class="col-md-12">
                    <?= $this->render('table', ['product_types' => $product_types, 'model' => $model]) ?>
                </div>
                <br>
<!--                <br>-->
<!--                <br>-->
                <br>
<!--                <div class="col-md-12">-->
<!--                    <?//= $this->render('all_products_chart.php', ['product_types' => $product_types, 'payment_model' => $payment_model]) ?>-->
<!--                </div>-->

            </div>
        </div>
    </div>
</div>


</div>
<?php }} ?>
<script type="text/javascript">
    function getPaymentTypeStats() {
        $('#filter-form').submit();
    }
</script>

<?php if(!$is_authorized) { ?>
    <script type="text/javascript">
        $(document).ready(function(){
            $('#secure_report_modal').modal('show');
        });
    </script>
<?php } ?>
