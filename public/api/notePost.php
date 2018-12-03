<?php

$note = new Note($_POST);

$note->create();

echo json_encode($note);
