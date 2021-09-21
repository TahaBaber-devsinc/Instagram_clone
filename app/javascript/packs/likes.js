import { $ } from "@rails/ujs";

$(function () {
  ":button".on("click", function (e, data, status, xhr) {
    console.log("click");
    var post_id = $(this).data("id");

    $.ajax({
      url: "",
      method: "GET",
    }).done(function (response) {
      console.log("Hello");
      e.preventDefault();
    });
  });
});
