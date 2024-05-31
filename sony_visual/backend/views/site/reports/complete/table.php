<?php
/* @var $model common\models\SaleReport */

use common\models\ElectronicsVendorOrder;
use common\models\ProductBooking;

?>


<table class="items table table-bordered">
    <tr>
        <th><?php echo Yii::t('app', 'Month') ?></th>
        <th><?php echo Yii::t('app', 'Sales') ?></th>
<!--        <?php //if(($model->employee == null || $model->employee == 0) && ($model->product_type == 0 && $model->product_model == 0)){?>-->
        <th><?php  echo Yii::t('app', 'All Sales Payment') ?></th>
        <th><?php  echo Yii::t('app', 'All Payment Spent') ?></th>
        <th><?php echo Yii::t('app', 'All Cash Payments'); ?></th>
        <th><?php echo Yii::t('app', 'Down Payments'); ?></th>
        <th><?php echo Yii::t('app', 'Installments Received') ?></th>
        <th><?php echo Yii::t('app', 'Total Payment Received'); ?></th>
        <th><?php echo Yii::t('app', 'Payment Due'); ?></th>
        <th><?php echo Yii::t('app', 'Profit'); ?></th>
    </tr>
    <?php
    $months = [];
    $data = [];
    $start = strtotime($model->start_date);
    $startDate = $start;

    $endDate = strtotime($model->end_date);

    $total_sale = 0;
    $total_sale_payment_spent = 0;
    $total_payment_spent = 0;
    $total_cash_payment = 0;
    $total_down_payment = 0;
    $total_installments_received = 0;
    $total_payment_received = 0;
    $total_payment_due = 0;
    $total_profit = 0;
    $i = 0;
    while ($startDate <= $endDate) {

        $start_time = $i == 0 ?  date("Y-m-d 00:00:00",$startDate) : date("Y-m-01 00:00:00",$startDate) ;
        $end_time = date("Y-m-t 23:59:59",$startDate);
        $end_time = strtotime($end_time) < $endDate ? $end_time : date("Y-m-d 23:59:59",$endDate);

        $sale = ProductBooking::getSaleReport($model, $start_time, $end_time);
        $sale_payment_spent = ProductBooking::getPaymentSpentOnSaleReport($model, $start_time, $end_time);
        $payment_spent = ProductBooking::getPaymentSpentReport($model, $start_time, $end_time);
        $cash_payment = ProductBooking::getCashPayments($model, $start_time, $end_time);
        $down_payment = ProductBooking::getDownPaymentReport($model, $start_time, $end_time);
        $installments_received = ProductBooking::getInstallmentsReport($model, $start_time, $end_time);
        $payment_received = ProductBooking::getPaymentReceivedReport($model, $start_time, $end_time);
        $payment_due = $sale_payment_spent - $payment_received;
        $profit = $sale_payment_spent - $payment_spent;

//        $amount_received_down_payment = ProductBooking::getProductSalesReport($model, $start_time, $end_time, ProductBooking::REPORT_REVENUE_DOWN_PAYMENT);
//        $amount_received = ProductBooking::getProductSalesReport($model, $start_time, $end_time, ProductBooking::REPORT_REVENUE);
//        $amount_spent = ProductBooking::getProductSalesReport($model, $start_time, $end_time, ProductBooking::REPORT_EXPENDS);
//        $amount_spent = ProductBooking::getPaymentSpentOnOrdersReport($model, $start_time, $end_time);
//        $amount_due = ElectronicsVendorOrder::getOrdersAmount(true,$start_time, $end_time);
//        $amount_due = 0;
        $month = date('M Y', $startDate);
        $months[] = $month;
        $data[] = $sale;
        $total_sale += $sale;
        $total_sale_payment_spent += $sale_payment_spent;
        $total_payment_spent += $payment_spent;
        $total_cash_payment += $cash_payment;
        $total_down_payment += $down_payment;
        $total_installments_received += $installments_received;
        $total_payment_received += $payment_received;
        $total_payment_due += $payment_due;
        $total_profit += $profit;
        $i++;
        ?>

        <tr>
            <td><?= $month ?></td>
            <td><?= $sale ?></td>
            <td><?php echo $sale_payment_spent; ?></td>
            <td><?php echo $payment_spent; ?></td>
            <td><?php echo $cash_payment; ?></td>
            <td><?php echo $down_payment; ?></td>
            <td><?php echo $installments_received;?></td>
            <td><?php echo $payment_received; ?></td>
            <td><?php echo $payment_due; ?></td>
            <td><?php echo $profit; ?></td>

        </tr>
        <?php
        $startDate = strtotime('+1 month', $startDate);
    }
    ?>

    <tr>
        <th><?= Yii::t('app', 'Total') ?></th>
        <th><?= $total_sale; ?></th>
        <th><?php echo $total_sale_payment_spent; ?></th>
        <th><?php echo $total_payment_spent; ?></th>
        <th><?php echo $total_cash_payment; ?></th>
        <th><?php echo $total_down_payment; ?></th>
        <th><?php echo $total_installments_received; ?></th>
        <th><?php echo $total_payment_received; ?></th>
        <th><?php echo $total_payment_due; ?></th>
        <th><?php echo $total_profit; ?></th>
    </tr>
</table>

