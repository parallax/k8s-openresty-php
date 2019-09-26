<?php
function human_filesize($bytes, $decimals = 2) {
  $sz = 'BKMGTP';
  $factor = floor((strlen($bytes) - 1) / 3);
  return sprintf("%.{$decimals}f", $bytes / pow(1024, $factor)) . @$sz[$factor];
}

$target_dir = "/efs/php-tmp/";
$target_file = $target_dir . basename($_FILES["fileToUpload"]["name"]);
$uploadOk = 1;

// Check if image file is a actual image or fake image
if(isset($_POST["submit"])) {
    $size = filesize($_FILES["fileToUpload"]["tmp_name"]);
    echo "Size: " . human_filesize($size) . "<br />";
}

$md5 = md5_file($_FILES["fileToUpload"]["tmp_name"]);

echo $md5;

?>