$(document).ready(function(){
    $('.datepicker').datepicker({
        format: 'dd/mm/yyyy',
        startDate: '-3d'
    });
    $('.check').click(function(e) {
        var form = document.createElement("form");
        form.setAttribute("method", "post");
        form.setAttribute("action", "/tasks/toggle");

        var hiddenField = document.createElement("input");
        hiddenField.setAttribute("type", "hidden");
        hiddenField.setAttribute("name", "id");
        hiddenField.setAttribute("value", this.id);
        form.appendChild(hiddenField);

        var hiddenField = document.createElement("input");
        hiddenField.setAttribute("type", "hidden");
        hiddenField.setAttribute("name", "authenticity_token");
        hiddenField.setAttribute("value", $('input[name=authenticity_token]').val());
        form.appendChild(hiddenField);

        var checked;
        if ($(this).is(':checked')) {
            checked = true;
        } else {
            checked = false;
        }
        var hiddenField = document.createElement("input");
        hiddenField.setAttribute("type", "hidden");
        hiddenField.setAttribute("name", "checked");
        hiddenField.setAttribute("value", checked);
        form.appendChild(hiddenField);

        document.body.appendChild(form);
        form.submit();
    });

    var el = document.getElementById('today_incomplete');
    var sortable = Sortable.create(el, {
        group: 'item',
        sort: false,
        onAdd: function(e) {
            console.log(e)
            alert("dragged from "+e.from)
        }
    });

    var el = document.getElementById('today_complete');
    var sortable = Sortable.create(el, {
        group: 'item',
        sort: false,
        onAdd: function(e) {
            console.log($(e.item).children('input[type=checkbox]'))
            //alert("dragged from "+$(e.item).children('input[type=checkbox]').attr('id'))
            var item_id = $(e.item).children('input[type=checkbox]').attr('id').replace("task_","");
            alert(item_id)
            //var form = document.createElement("form");
            //form.setAttribute("method", "post");
            //form.setAttribute("action", "/tasks/");
            //
            //var hiddenField = document.createElement("input");
            //hiddenField.setAttribute("type", "hidden");
            //hiddenField.setAttribute("name", "id");
            //hiddenField.setAttribute("value", this.id);
            //form.appendChild(hiddenField);
            //
            //var hiddenField = document.createElement("input");
            //hiddenField.setAttribute("type", "hidden");
            //hiddenField.setAttribute("name", "authenticity_token");
            //hiddenField.setAttribute("value", $('input[name=authenticity_token]').val());
            //form.appendChild(hiddenField);
            //
            //var checked;
            //if ($(this).is(':checked')) {
            //    checked = true;
            //} else {
            //    checked = false;
            //}
            //var hiddenField = document.createElement("input");
            //hiddenField.setAttribute("type", "hidden");
            //hiddenField.setAttribute("name", "checked");
            //hiddenField.setAttribute("value", checked);
            //form.appendChild(hiddenField);
            //
            //document.body.appendChild(form);
            //form.submit();

        }
    });
});