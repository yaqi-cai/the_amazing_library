<!DOCTYPE html>
<?php session_start(); ?>
<html>
    <head>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

        <title></title>
    </head>
    <body>
        <?php
        $dsn = "mysql:host=127.0.0.1;dbname=finalversion_database";
        $user = "root";
        $password = NULL;
        $options = NULL;
        $message = "";

        try {
            $pdo = new PDO($dsn, $user, $password, $options);
            $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            if (isset($_POST['search'])) {
                $title = $_POST['title'];
                $stmt = $pdo->prepare("SELECT title FROM book WHERE title = :title");
                $stmt->bindParam(":title", $title, PDO::PARAM_STR);
                $stmt->execute();
                $count = $stmt->rowCount();               
                $data = $stmt->fetch(PDO::FETCH_OBJ);

                if ($count > 0) {
                  $output ='<label>We have this book!</label>';
                } else {
                   $message = '<label>This book is unavailable!</label>';
                }
            }
        } catch (Exception $e) {
            $message = $e->getMessage();
        }
        ?>
        <div class="container">
            <div class ="col-xm-6">  
                <form action="" method="POST">

                    <div class="form-group">
                        <label for="keyword">Seaching For</label>
                        <input type="text" name="title" class="form-control" id="inputlg" required> 
                    </div>


                    <input  class="btn btn-primary" type="submit" name="search" value="Submit">
                </form>
            <?php
            if(isset($output)){
                echo '<label class="text-danger">' . $output . '</label>';
            }
            if (isset($message)) {
                echo '<label class="text-danger">' . $message . '</label>';
            }
            ?>
    </body>
</html>
