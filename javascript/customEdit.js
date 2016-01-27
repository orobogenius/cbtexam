$(document).ready(function(){
  $('#foreColor').css("color", "red");
})


function iFrameOn()
{
    richTextField.document.designMode = 'On';
}

function bold()
{
    richTextField.document.execCommand('bold', false, null);
}

function underline()
{
  richTextField.document.execCommand('underline', false, null);
}

function italic()
{
  richTextField.document.execCommand('italic', false, null);
}

function fontSize()
{
  var size = document.getElementById('fSize').value;
  richTextField.document.execCommand('FontSize', false, size);
}

function foreColor()
{

}

function horizontalRule()
{
  richTextField.document.execCommand('InsertHorizontalrule', false, null);
}

function unorderedList()
{
  richTextField.document.execCommand('InsertUnrderedList', false, "newUL");
}

function orderedList()
{
  richTextField.document.execCommand('InsertOrderedList', false, "newOL");
}

function getImage()
{
  var imgSrc = document.getElementById("image").value.replace("C:\\fakepath\\", "");
  if (imgSrc != null)
  {
    richTextField.document.execCommand('insertimage', false, imgSrc);
  }
}

function submitForm()
{
  document.getElementById("myTextArea").value = window.frames['richTextField'].document.body.innerHTML;
  document.getElementById("myform").submit();
}
