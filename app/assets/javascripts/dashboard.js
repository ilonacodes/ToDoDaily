function onAddFormPress(event) {
    var key = event.keyCode;

    if (key === 13) {
        var form = document.getElementById('add_task_form');
        form.submit()
    }
}

