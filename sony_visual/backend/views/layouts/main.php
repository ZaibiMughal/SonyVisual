<?php

/** @var \yii\web\View $this */
/** @var string $content */

use backend\assets\AppAsset;
use common\widgets\Alert;
use yii\bootstrap4\Breadcrumbs;
use yii\bootstrap4\Html;
use yii\bootstrap4\Nav;
use yii\bootstrap4\NavBar;

AppAsset::register($this);
?>
<?php $this->beginPage() ?>
<!DOCTYPE html>
<html lang="<?= Yii::$app->language ?>" class="h-100">
<head>
    <meta charset="<?= Yii::$app->charset ?>">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <?php $this->registerCsrfMetaTags() ?>
    <title><?= Html::encode($this->title) ?></title>
    <?php $this->head() ?>
    <style>
        .kv-grid-container{
            overflow-x: auto;
            width: 100%;
        }
        .bg-secondary{
            background-color: #000000 !important;
        }

        .border-secondary {
            border-color: #0c1c1f !important;
        }
    </style>
</head>
<body class="d-flex flex-column h-100">
<?php $this->beginBody() ?>



<!--<div class="wrap">-->
<div class="">
    <div class="container-fluid">
        <br/><br/><br/><br/><br/>

        <?php
        if (!Yii::$app->user->isGuest) {
            echo $this->render('//navbar');
        }
        ?>


        <?=
        Breadcrumbs::widget([
            'links' => isset($this->params['breadcrumbs']) ? $this->params['breadcrumbs'] : [],
        ])
        ?>
        <?= $this->render('//flash-alert') ?>

        <?= $content ?>
    </div>
</div>

<!--<header>-->
<!--    --><?php
//    NavBar::begin([
//        'brandLabel' => Yii::$app->name,
//        'brandUrl' => Yii::$app->homeUrl,
//        'options' => [
//            'class' => 'navbar navbar-expand-md navbar-dark bg-dark fixed-top',
//        ],
//    ]);
//    $menuItems = [
//        ['label' => 'Home', 'url' => ['/site/index']],
//    ];
//    if (Yii::$app->user->isGuest) {
//        $menuItems[] = ['label' => 'Login', 'url' => ['/site/login']];
//    } else {
//        $menuItems[] = '<li>'
//            . Html::beginForm(['/site/logout'], 'post', ['class' => 'form-inline'])
//            . Html::submitButton(
//                'Logout (' . Yii::$app->user->identity->username . ')',
//                ['class' => 'btn btn-link logout']
//            )
//            . Html::endForm()
//            . '</li>';
//    }
//    echo Nav::widget([
//        'options' => ['class' => 'navbar-nav'],
//        'items' => $menuItems,
//    ]);
//    NavBar::end();
//    ?>
<!--</header>-->

<!--<main role="main" class="flex-shrink-0">-->
<!--    <div class="container">-->
<!--        <?//= Breadcrumbs::widget([
//            'links' => isset($this->params['breadcrumbs']) ? $this->params['breadcrumbs'] : [],
//        ]) ?>-->
<!--        --><?//= Alert::widget() ?>
<!--        --><?//= $content ?>
<!--    </div>-->
<!--</main>-->

<footer class="footer mt-auto py-3 text-muted">
    <div class="container">
        <p class="float-left">&copy; <?= Html::encode(Yii::$app->name) ?> <?= date('Y') ?></p>
        <p style="text-align: center;">
            CURRENT TIMEZONE: <?= date_default_timezone_get() ?>
            <br/>
            CURRENT TIME: <?= date('d/m/Y h:i A') ?>
        </p>
    </div>
</footer>

<?php $this->endBody() ?>
<script type="text/javascript">
    $.fn.modal.Constructor.prototype.enforceFocus = function () {};

    $(document).ready(function(){
        if (window.matchMedia("(max-width: 767px)").matches)
        {
            $('.kv-grid-table').removeClass('kv-table-wrap');

            // The viewport is less than 768 pixels wide
            // document.write("This is a mobile device.");
        } else {

            // The viewport is at least 768 pixels wide
            // document.write("This is a tablet or desktop.");
        }
    });
</script>
</body>
</html>
<?php $this->endPage();
