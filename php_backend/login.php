<?php
$conn = new mysqli("localhost", "root", "", "flutter_login");

// Check if POST variables are set
if (isset($_POST['username']) && isset($_POST['password'])) {
    $username = $_POST['username'];
    $password = $_POST['password'];

    $query = "SELECT * FROM users WHERE username='$username' AND password='$password'";
    $result = $conn->query($query);

    if ($result->num_rows > 0) {
        echo json_encode(["status" => "success"]);
    } else {
        echo json_encode(["status" => "failed"]);
    }
} else {
    // No POST data received
    echo json_encode(["status" => "failed"]);
}
?>
