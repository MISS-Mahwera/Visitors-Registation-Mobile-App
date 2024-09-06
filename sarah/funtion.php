<?php
echo"<h1>FUNCTION,local,global & constant variable</h1>";

    function grade($marks) {

        if($marks <=100 && $marks>=96){
            echo 'Grade A ';
        }
        else if ($marks <=74 && $marks >=65){
            echo 'Grade B';
        }
        else if($marks <=64 && $marks>=5){
            echo 'Grade C';
        }
        else if ($marks <=4 && $marks >=0){
            echo 'Grade D';    
        }     
    }

    grade(96);
    echo "<br>";

    grade(74);
    echo "<br>";

    grade(64);
    echo "<br>";
    
    grade(4);