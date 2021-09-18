import { $ } from "@rails/ujs";

$(function () {
  $(".post-like").on("click", function (e, data, status, xhr) {
    var post_id = $(this).data("id");

    $.ajax({
      url: "",
      method: "GET",
    }).done(function (response) {
      console.log(response);
      e.preventDefault();
    });
  });
});
