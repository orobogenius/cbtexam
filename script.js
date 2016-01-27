function getNextQues(formValues)
{
	$.ajax({
			method: "POST",
			url: "getQues.php",
			data: formValues,
			success: function(data){
				$('.question').html(data);
			}
		});
}

$(document).ready(function(){
	$('form#questionForm').on('submit', function(event){
		event.preventDefault();
		getNextQues($(this).serialize());
	});
	$('body').on('click','button#submit', function(event){
		event.preventDefault();
		getNextQues($(this).parent().serialize());
	})
});