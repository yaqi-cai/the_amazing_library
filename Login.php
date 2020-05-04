<!DOCTYPE html>
<?php session_start(); ?>

<html>
    <head>
        <meta charset="UTF-8">
        <title>Library Login Form</title>

        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

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
            if (isset($_POST['login'])) {
                $username = $_POST['username'];
                $password = $_POST['password'];
                $stmt = $pdo->prepare("SELECT username, password FROM membership WHERE username =:username and password = :password");
                $stmt->bindParam(":username", $username, PDO::PARAM_STR);
                $stmt->bindParam(":password", $password, PDO::PARAM_STR);
                $stmt->execute();
                $count = $stmt->rowCount();
                $data = $stmt->fetch(PDO::FETCH_OBJ);

                if ($count > 0) {
//                    $_SESSION(firstname) = $_POST["firstname"];
//                    $_SESSION(lastname) = $_POST["lastname"];
//                    $_SESSION('uid') = $_POST["username"];
//                    $_SESSION(email) = $_POST["email"];
//                    $_SESSION(password) = $_POST["password"];
                    header("location: dashboard.php");
                } else {

                    $message = '<label>Please enter the required details</label>';
                }
            }
        } catch (Exception $e) {
            $message = $e->getMessage();
        }
        ?>

        <h3 align="center">Library Login Form</h3><br/>



        <div class="container">
            <div class ="col-xm-6">  
                <form action="" method="POST">

                    <div class="form-group">
                        <label for="userame">Username</label>
                        <input type="text" name="username" class="form-control" id="inputlg" required> 
                    </div>
                    <div class="form-group">
                        <label for="password">Password</label>
                        <input type="password" name="password" class="form-control" id="inputlg" required> 
                    </div>


                    <input  class="btn btn-primary" type="submit" name="login" value="Submit">
                </form>
                <br>
                <br>

                <?php
                if (isset($message)) {
                    echo '<label class="text-danger">' . $message . '</label>';
                }
                ?>



            </div>
        </div>
    </div>       
</body>
</html>
