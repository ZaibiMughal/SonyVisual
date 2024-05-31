<?php

?>
<table class="items table table-bordered">
    <?php foreach ($modules as $module){ ?>
        <tr>
            <td><?=  $module ?></td>
            <td>
                <?= $data['month'][$module]?>
            </td>
        </tr>
    <?php } ?>
</table>