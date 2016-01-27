function isNumberKey(evt){
  var charCode = (evt.which) ? evt.which : event.keyCode;
  return !(charCode > 31 && (charCode < 48 || charCode > 57));

}

function validateFields()
{
	var pass = $('#pass').val();
  var conpass = $('#conPass').val();

	if (pass.length < 8)
	{
		alert("Password should be at least 8 characters");
		return false;
	}
	if (conpass.length < 8)
	{
		alert("Password should be at least 8 characters");
		return false;
	}
  if (pass != conpass)
  {
    alert("Passwords do not match");
    $('#pass').focus();
    return false;
  }
}

function submitForm(event)
{
  $(event).closest('form').submit();
}

var ss = 0;
var mm = 0;
var hh = 0;
var timer;

function CountDownTimer()
{
  if (sessionStorage.getItem('hh') && sessionStorage.getItem('mm') && sessionStorage.getItem('ss'))
  {
    mm = sessionStorage.getItem('mm');
    ss = sessionStorage.getItem('ss');
    hh = sessionStorage.getItem('hh');
  }
  var $testTimer = $('#testTimer');
  if (ss==-1)
      ss=60;
  $testTimer.text(hh+"h:"+mm+"m:"+ss+"s");
  ss--;
  if (ss<0){
      if (mm>0){
          mm--;
          ss=59;
      }
      else if (hh>0){
          hh--;
          mm=59;
      }
      else {
          //Complete
          clearInterval(timer);
          alert("Timeout!");
          $('#questionForm').submit();
      }
  }
  else if (mm<10)
      $testTimer.css("color", "red");
  if (mm<=0)
  {
    sessionStorage.setItem('ss', ss);
    sessionStorage.setItem('mm', mm);
    sessionStorage.setItem('hh', hh);
  }
  else
  {
    sessionStorage.setItem('ss', ss);
    sessionStorage.setItem('mm', mm);
    sessionStorage.setItem('hh', hh);
  }
  //alert(localStorage.getItem('item'));
}

function setDuration(duration)
{
  if (sessionStorage.getItem('hh') && sessionStorage.getItem('mm') && sessionStorage.getItem('ss'))
  {
    mm = sessionStorage.getItem('mm');
    ss = sessionStorage.getItem('ss');
    hh = sessionStorage.getItem('hh');
  } else {
    mm = duration;
    if (mm>60)
    {
      hh=Math.floor(mm/60);
      mm%=60;
    }
    if (mm<0)
    {
      ss=mm*-1;
      mm=0;
    }
  }
  return hh+'h'+':'+mm+'m'+':'+ss+'s';
}

$(document).ready(function(){
    $('#copyright-year').html((new Date).getFullYear());
    $('#clear').click(function(event){
      event.preventDefault();
      $(this).closest('form')[0].reset();
    });
    $('#setActive').click(function(){
      if ($(this).prop('checked'))
      {
          if ($('#setInactive').prop('checked'))
          {
              $('#setInactive').attr('checked', false);
          }
          $('#setInactive').attr('disabled', true);
      } else {
          $('#setInactive').attr('disabled', false);
      }
    });
    $('#setInactive').click(function(){
      if ($(this).prop('checked'))
      {
          $('#setActive').attr('disabled', true);
      } else {
          $('#setActive').attr('disabled', false);
      }
    });
    $('#setActiveInactive').click(function(){
      //Get the number of tests that was checked, if more than one throw error
      var i = 0;
      var numChecked = 0;
      var numOfCheckBoxes = $('#testsTable input[type="checkbox"]').length;
      for (i; i< numOfCheckBoxes; i++)
      {
        if ($('#testID'+i).is(':checked'))
        {
          numChecked++;
        }
      }
      if (numChecked>1)
      {
        event.preventDefault();
        $('#infoPanel')
            .css('display', "block")
            .animate()
              .find("span")
                .css("color", "red")
                .html("You can only set tests as Active or Inactive one at a time");
      }
    });

    $('#beginTest').click(function(){
      $('#testDescription').css("display", "none");
      $(this).css("display", "none");
      $('#testName')
        .insertAfter('#testTimer');
      timer = setInterval(CountDownTimer, 1000);
    });
    $('#testNameSide')
        .insertAfter('#testTimer');
    //$('#start').click();
    var testDuration = $('#testTimer').text();
    if (sessionStorage.getItem('time'))
    {
      $('#testTimer').html(setDuration(sessionStorage.getItem('time')));
    } else {
      $('#testTimer').html(setDuration(testDuration));
    }
    /* Custom Edit Functions */
    $('#richTextField').contents().prop('designMode','on');
    $('body').on('click', '#bold', function(){
      document.getElementById('richTextField').contentWindow.document.execCommand('bold', false, null);
    })
    $('body').on('click', '#underline', function(){
      document.getElementById('richTextField').contentWindow.document.execCommand('underline', false, null);
    })
    $('body').on('click', '#italic', function(){
      document.getElementById('richTextField').contentWindow.document.execCommand('italic', false, null);
    })
    $('body').on('change', '#fSize', function(){
      var size = $(this).val();
      document.getElementById('richTextField').contentWindow.document.execCommand('FontSize', false, size);
    })
    $("#foreColor").spectrum({
        color: "#000",
        change: function(color){
            document.getElementById('richTextField').contentWindow.document.execCommand('ForeColor', false, color.toHex());
        }
    });

    $('body').on('change', '#foreColor', function(){
      var color = $(this).spectrum('get');

    })
    $('body').on('click', '#horizontalRule', function(){
      document.getElementById('richTextField').contentWindow.document.execCommand('InsertHorizontalrule', false, null);
    })
    $('body').on('click', '#unorderedList', function(){
      document.getElementById('richTextField').contentWindow.document.execCommand('InsertUnorderedList', false, "newUL");
    })
    $('body').on('click', '#orderedList', function(){
      document.getElementById('richTextField').contentWindow.document.execCommand('InsertOrderedList', false, "newOL");
    })
    $('body').on('click', '#loadImage', function(){
      var imgSrc = $('#image').val().replace("C:\\fakepath\\", "../images/");
      if (imgSrc != null)
      {
        document.getElementById('richTextField').contentWindow.document.execCommand('insertimage', false, imgSrc);
      }
    })
    $('body').on('click', '#add', function(){
      $('#question').html(window.frames['richTextField'].document.body.innerHTML);
      //alert($('#question').html());
      $(this).closest('form').submit();
    });
});
