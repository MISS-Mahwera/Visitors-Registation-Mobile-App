<?php
//conditional statements
$marks = 47;
if($marks <=100 && $marks>=80){
echo 'Grade A ';
}
else if ($marks <=79 && $marks >=65){
    echo 'Grade B';
}
else if($marks <=50 && $marks >=45){
    echo 'Grade C';
}

const gender = 'male';
function add ($a,$b){
$c=$a + $b;
echo$c;
}
//function call
add(7,6);
echo gender;