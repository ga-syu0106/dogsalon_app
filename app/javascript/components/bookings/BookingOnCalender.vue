<template>
  <v-app>
        <v-sheet tile height="4vh" color="grey lighten-3" class="d-flex align-center">
          <v-btn icon @click="$refs.calendar.prev()">
            <v-icon>mdi-chevron-left</v-icon>
          </v-btn>
          <v-btn icon @click="$refs.calendar.next()" id="next-month-right">
            <v-icon>mdi-chevron-right</v-icon>
          </v-btn>
          <v-toolbar-title>{{ title }}</v-toolbar-title>
        </v-sheet>
        <v-sheet height="150vh">
          <v-calendar
            ref="calendar"
            v-model="value"
            :events="bookings"
            :event-color="getEventColor"
            locale="ja-jp"
            :day-format="(timestamp) => new Date(timestamp.date).getDate()"
            :month-format="(timestamp) => new Date(timestamp.date).getMonth() + 1 + ' /'"
            @change="getEvents"
            @click:event="showEvent"
            @click:date="viewDay"
          ></v-calendar>
        </v-sheet>
    <BookingOnCalenderDay ref="dlg" v-model="value_click" @set-time-event="inputWorkTime" v-show="noneArea"></BookingOnCalenderDay>
  </v-app>
</template>

<script>
import axios from 'axios'
import moment from 'moment';
import BookingOnCalenderDay from './BookingOnCalenderDay.vue';


export default {
  data: () => ({
    events: [],
    bookings: [],
    value: moment().format('yyyy-MM-DD'),
    value_click: {},
    input_time: '',
    noneArea: false,
  }),
  components: {
    BookingOnCalenderDay,
  },
  computed: {
    title() {
      return moment(this.value).format('yyyy年 M月');
    },
  },
  mounted () {
    axios.get('/api/v1/bookings/month')
    .then((response) => {
      this.bookings = response.data;
    })
  },
  methods: {
    // setToday() {
    //   this.value = moment().format('yyyy-MM-DD');
    // },
    showEvent(day) {
      this.value_click = day;
      this.$refs.dlg.isDisplay = true

    },
    viewDay(day) {
      this.value_click = day;
      this.$refs.dlg.isDisplay = true;
  
    },
    getEvents() {
      const events = this.bookings;
      return this.bookings = events;
    },
    getEventColor(bookings) {
      return bookings.color;
    },
    inputWorkTime(payload) {
      this.input_time = payload;
      this.inputEmit();
    },

    inputEmit() {
      this.$emit('set-time-event-child', this.input_time);
    }
    // openDisplay() {
    //   this.$refs.dlg.isDisplay = true
    // },
    // eventNameFormatter(event, timedEvent) {
    //   if (timedEvent) {
    //     return event.input.name;
    //   }
    //   if (event.allDay || !event.hasTime) {
    //     return event.input.name;
    //   }
    //   return moment(String(event.start.time)).format('HH:MM') + " a" + event.input.name;
    // }
  },
};
</script>