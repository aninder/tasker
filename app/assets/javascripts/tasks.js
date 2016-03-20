function create_authenticity_token_field(){
    var hiddenField = document.createElement("input");
    hiddenField.setAttribute("type", "hidden");
    hiddenField.setAttribute("name", "authenticity_token");
    hiddenField.setAttribute("value", $('input[name=authenticity_token]').val());

    return hiddenField;
}

function create_patch_request_field() {
    var hiddenField = document.createElement("input");
    hiddenField.setAttribute("type", "hidden");
    hiddenField.setAttribute("name", "_method");
    hiddenField.setAttribute("value", "patch");

    return hiddenField;
}

function create_task_field(k, v) {
    var hiddenField = document.createElement("input");
    hiddenField.setAttribute("type", "hidden");
    hiddenField.setAttribute("name", "task["+k+ "]");
    hiddenField.setAttribute("value", v);

    return hiddenField;
}

$(document).ready(function(){
    $('.datepicker').datepicker({
        format: 'dd/mm/yyyy',
        startDate: '-3d'
    });
    $('.check').click(function(e) {
        var form = document.createElement("form");
        form.setAttribute("method", "post");
        form.setAttribute("action", "/tasks/"+this.id.replace("task_",""));

        form.appendChild(create_authenticity_token_field());
        form.appendChild(create_patch_request_field());

        var checked;
        if ($(this).is(':checked')) {
            checked = true;
        } else {
            checked = false;
        }
        form.appendChild(create_task_field('completed', checked));

        if(checked) {
            date = new Date();
            form.appendChild(create_task_field('finish_date(1i)', date.getFullYear()));
            form.appendChild(create_task_field('finish_date(2i)', date.getMonth()+1));
            form.appendChild(create_task_field('finish_date(3i)', date.getDate()));
        } else {
            date = new Date();
            form.appendChild(create_task_field('start_date(1i)', date.getFullYear()));
            form.appendChild(create_task_field('start_date(2i)', date.getMonth()+1));
            form.appendChild(create_task_field('start_date(3i)', date.getDate()));
        }

        document.body.appendChild(form);
        form.submit();
    });

    var byId = function (id) { return document.getElementById(id); }

    var sortable = Sortable.create(byId('today_incomplete'), {
        animation: 150,
        filter: '.js-remove',
        onFilter: function (evt) {
            evt.item.parentNode.removeChild(evt.item);
        },
        group: 'item',
        sort: false,
        onAdd: function(e) {
            console.log(e)
            //alert("dragged from "+e.from)
        }
    });

    byId('addTask').onclick = function () {
        Ply.dialog('prompt', {
            title: 'Add',
            form: { name: 'name' }
        }).done(function (ui) {
            var el = document.createElement('li');
            el.innerHTML = ui.data.name + '<i class="js-remove">✖</i>';
            editableList.el.appendChild(el);
        });
    };



    var el = document.getElementById('today_complete');
    var sortable = Sortable.create(el, {
        group: 'item',
        sort: false,
        onAdd: function(e) {
            console.log($(e.item).children('input[type=checkbox]'))
            var item_id = $(e.item).children('input[type=checkbox]').attr('id').replace("task_","");
            //alert(item_id)

            var form = document.createElement("form");
            form.setAttribute("method", "post");
            form.setAttribute("action", "/tasks/"+item_id);

            form.appendChild(create_authenticity_token_field());
            form.appendChild(create_patch_request_field());
            form.appendChild(create_task_field('completed', true));

            date = new Date();
            form.appendChild(create_task_field('finish_date(1i)', date.getFullYear()));
            form.appendChild(create_task_field('finish_date(2i)', date.getMonth()));
            form.appendChild(create_task_field('finish_date(3i)', date.getDate()));

            document.body.appendChild(form);
            form.submit();
        }
    });
});