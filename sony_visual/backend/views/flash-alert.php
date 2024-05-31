<?php

use yii\bootstrap4\Alert;

function getHtml($messages){
    if($messages != null && count($messages)  > 0) {
        $html = "<ul style='margin-bottom: 0 !important;'>";
        foreach ($messages as $message) {
            $html = $html . "<li>" . $message . "</li>";
        }
        $html = $html . "</ul>";
        return $html;
    }
}

if (Yii::$app->session->hasFlash('alert_error')) {
    Alert::begin([
        'options' => [
            'class' => 'alert-danger',
        ],
    ]);
    $messages = Yii::$app->session->getFlash('alert_error');
    echo getHtml($messages);
    Alert::end();
}

if (Yii::$app->session->hasFlash('alert_success')) {

    Alert::begin([
        'options' => [
            'class' => 'alert-success',
        ],
    ]);
    $messages = Yii::$app->session->getFlash('alert_success');
    echo getHtml($messages);
    Alert::end();
}

if (Yii::$app->session->hasFlash('alert_warning')) {

    Alert::begin([
        'options' => [
            'class' => 'alert-warning',
        ],
    ]);
    $messages = Yii::$app->session->getFlash('alert_warning');
    echo getHtml($messages);
    Alert::end();
}

