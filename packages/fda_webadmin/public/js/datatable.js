$(document).ready(function () {
  // Setup - add a text input to each footer cell
  $("#pending-payout thead .datatable-filter-line").each(function () {
    $(this).html('<input type="text"/>');
  });

  // DataTable
  var table = $("#pending-payout").DataTable({
    initComplete: function () {
      // Apply the search
      this.api()
        .columns()
        .every(function () {
          var that = this;

          $("input", this.header()).on("keyup change clear", function () {
            if (that.search() !== this.value) {
              that.search(this.value).draw();
            }
          });
        });
    },
  });
});
