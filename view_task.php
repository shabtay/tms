<?php 
include 'db_connect.php';
if(isset($_GET['id'])){
	$qry = $conn->query("SELECT * FROM task_list where id = ".$_GET['id'])->fetch_array();
	foreach($qry as $k => $v){
		$$k = $v;
	}
}
?>
<div class="container-fluid">
	<dl>
		<dt><b class="border-bottom border-primary">משימה</b></dt>
		<dd><?php echo ucwords($task) ?></dd>
	</dl>
	<dl>
		<dt><b class="border-bottom border-primary">סטטוס</b></dt>
		<dd>
			<?php 
        	if($status == 1){
		  		echo "<span class='badge badge-secondary'>בהשהיה</span>";
        	}elseif($status == 2){
		  		echo "<span class='badge badge-primary'>בתהליך</span>";
        	}elseif($status == 3){
		  		echo "<span class='badge badge-success'>הסתיים</span>";
        	}
        	?>
		</dd>
	</dl>
	<dl>
		<dt><b class="border-bottom border-primary">תיאור</b></dt>
		<dd><?php echo html_entity_decode($description) ?></dd>
	</dl>
</div>