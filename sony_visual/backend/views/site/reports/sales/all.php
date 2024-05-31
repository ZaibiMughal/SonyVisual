<?php

?>
<table class="items table table-bordered">
    <?php foreach ($modules as $module){ ?>
        <tr>
            <td><?=  $module ?></td>
            <td>
                <?= $data['all'][$module]?>
            </td>
        </tr>
    <?php } ?>
</table>