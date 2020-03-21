import flatpickr from "flatpickr"
import "flatpickr/dist/flatpickr.min.css"

flatpickr(".datepicker", {
  enableTime: true,
  dateFormat: "d.m.Y",
  minDate: "today",
  mode: "range",
  //onChange: function(selectedDates) {
  //  let from = selectedDates[0];
  //  let to = selectedDates[1];
  //};
});
