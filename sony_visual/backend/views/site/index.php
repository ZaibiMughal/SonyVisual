<?php
/* @var $this yii\web\View */

use common\models\PaymentType;
use yii\bootstrap4\Tabs;

$this->title = Yii::t('app', 'Reports');
//$product_types = ;
$payment_model = isset($data['payment_model']) ? $data['payment_model'] : null;
?>
<div class="row">
    <div class="col-md-5">
        <div class="card border-secondary">
            <div class="card-header bg-secondary text-white">
                <h3 class="panel-title"><i class="fa fa-globe" aria-hidden="true"></i> <?= $this->title?></h3>
            </div>
            <div class="card-body">

<!--                <form id="filter-form" class="form" method="GET" action="/" style="text-align: center;">-->
<!--                    <div class="form-group col-md-4 col-md-offset-4">-->
<!--                        <select id="product-type-select" class="form-control" name="payment_plan" onchange="getPaymentTypeStats()">-->
<!--                            --><?php
//                            $payments_plans = (new PaymentType())->getAll();
//
//                            if(count($payments_plans) > 1) {
//                                echo '<option value="0">All Payment Plans</option>';
//                            }
//                            foreach ($payments_plans as $payment_plan) { ?>
<!--                                <option value="--><?php //echo $payment_plan['id'];?><!--"-->
<!--                                    --><?php //if (isset($payment_model) && $payment_plan['id'] == $payment_model->getId()) {
//                                    echo 'selected=selected';
//                                    } ?>
<!--                                    --><?php //echo $payment_plan['name'];
//                                    ?>
<!--                                </option>-->
<!--                                --><?php
//                            }
//                            ?>
<!--                        </select>-->
<!--                    </div>-->
<!--                </form>-->

                <div class="col-md-12">
                    <?php
                    echo Tabs::widget([
                            'items' => [
                                ['label' => 'Today', 'content' => $this->render('reports/sales/today', ['modules' => $modules, 'data' => $data]), 'active' => true],
                                ['label' => 'Week', 'content' => $this->render('reports/sales/week', ['modules' => $modules,'data' => $data])],
                                ['label' => 'Month', 'content' => $this->render('reports/sales/month', ['modules' => $modules,'data' => $data]), ],
                                ['label' => 'All time', 'content' => $this->render('reports/sales/all', ['modules' => $modules,'data' => $data]), ],
                            ],
                        ]
                    );

                    ?>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-7">
        <?= $this->render('charts/all_products_chart.php', ['modules' => $modules]) ?>
    </div>
</div>

    <script type="text/javascript">
        function getPaymentTypeStats() {
            $('#filter-form').submit();
        }
    </script>
