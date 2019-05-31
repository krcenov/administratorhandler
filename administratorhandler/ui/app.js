function TextWithAdminbtnClickable() {
	TextWithAdminbtn = document.getElementById('TextWithAdminbtn');
	TextWithAdminbtn.onclick = function() 
	{
		$.post('http://administratorhandler/AdminCalled', JSON.stringify({}));
		$.post('http://administratorhandler/CallAdminForTextingToIAA', JSON.stringify({}));
	};
}
function MeetWithAdminbtnClickable() {
	MeetWithAdminbtn = document.getElementById('MeetWithAdminbtn');
	MeetWithAdminbtn.onclick = function() 
	{
		$.post('http://administratorhandler/AdminCalled', JSON.stringify({}));
		$.post('http://administratorhandler/CallAdminToIAA', JSON.stringify({}));
	};
}
$( document ).ready(function() 
{
	window.addEventListener( 'message', function( event )
	{
		var item = event.data;
		if (item.type == "ARM") 
		{
			if (item.display == true) 
			{
				$('#MenuFrame').css('display','block');
				
			}
			else if (item.display == false)
			{
				if (item.status != null)
				{
					$('#StatusFrame').css('display','block');
					document.getElementById('StatusText').innerHTML = "Status:"+item.status;
				}
				else
				{
					document.getElementById('StatusText').innerHTML = "Status:Unknown,Report to server owner!";
				}
			}
			else if (item.hide == true) 
			{
				$('#MenuFrame').css('display','none');
				$('#StatusFrame').css('display','block');
			}
			if (item.admin == true)
			{
				$('#AdminCalls').css('display','block');
			}
			else if (item.admin == false)
			{
				$('#AdminCalls').css('display','none');
			}
			if (item.AdminCalls != null) 
			{
				
			}
		}
	});
});
document.onkeyup = function (data) 
{
    if (data.which == 27) {
        $.post('http://administratorhandler/NUIFocusOff', JSON.stringify({}));
    }
};
TextWithAdminbtnClickable();
MeetWithAdminbtnClickable();
