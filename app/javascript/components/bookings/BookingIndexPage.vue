<template>
  <v-app id="app" class="top-margin">
    <div class="cyan lighten-3 pt-4 pb-2">
      <span class="ml-10">予約管理</span>
    </div>
    <v-container justify="center" class="col-11 text-caption">
      <v-row class="mt-6 col-11 mx-auto" justify-items="right">
        <v-spacer></v-spacer>
        <v-btn rounded color="primary" dark justify-items="right" @click="showEvent">予約新規作成</v-btn>
        <!-- <router-link :to="{ name: 'BookingNew' }">
        
        </router-link> -->
      </v-row>

      <v-row class="mt-6 mb-3" justify="center">
      <v-card class="col-6 mx-auto">
        <v-card-title>検索条件</v-card-title>
        <v-form :model="query">
          <!--  
            <v-menu v-model="menu" max-width="290px" min-width="290px">
              <template v-slot:activator="{ on }">
                <v-text-field
                  slot="activator"
                  v-model="query.start_date_time"
                  label="予約日"
                  readonly
                  v-on="on"
                />
              </template>
              <v-date-picker v-model="query.start_date_time" placeholder="予約日" no-title />
            </v-menu> -->
          
            <v-text-field label="名前(姓)" v-model="query.last_name_eq" placeholder="名前(姓)" class="mx-10" id="search-form-name"></v-text-field>
            <v-text-field label="携帯電話" v-model="query.mobilephone_eq" placeholder="携帯電話" class="mx-10" id="search-form-phone"></v-text-field>
      
        </v-form>
        <v-container class="d-flex justify-content-center">
        <v-btn class="ma-2 justifiy-content-center mr-3" outlined color="indigo" @click="search">search</v-btn>
        <v-btn class="ma-2 justifiy-content-center" outlined color="blue-grey" @click="reset" id="search-form-reset">reset</v-btn>
        </v-container>
      </v-card>
      
      </v-row>
    

  
      <v-row class="mt-6" justify="center">
        <table class="table table-bordered col-10 booking_index" outlined v-for="b in bookings" :key="b.id">
          <tbody>
  
           <tr>
       
          
              <th>顧客名</th>
              <td colspan="2">{{ b.last_name }} 様</td>
              <th>ペット名</th>
              <td colspan="2">
                {{ b.pet_name }} <span v-if="b.pet_gender == 'オス'">くん</span>
                <span v-else-if="b.pet_gender == 'メス'">ちゃん</span>
                <span v-else></span>
                </td>
            </tr>
            <tr>
              <th>メニュー</th>
              <td colspan="2">{{ b.menus.menu_and_price }}</td>
              <th>電子カルテ</th>
              <td colspan="2">確認ボタン</td>
            </tr>
            <tr>
              <th>同意書記入</th>
              <td colspan="2">済み・未　確認ボタン</td>
              <th>顧客情報記入</th>
              <td colspan="2">済み・未　確認ボタン</td>
            </tr>
            <tr>
              <th>予約日時</th>
              <td>{{ b.start_date_time }}〜{{ b.end_date_time }}</td>
              <th>前回来店日時</th>
              <td v-if="b.start_last_booking == 'Invalid Date'"></td>
              <td v-else>{{ b.start_last_booking }}〜{{ b.end_last_booking }}</td>
              <th>今回ご請求予定金額</th>
              <td>{{ b.menus.menu_sum_price }}</td>
            </tr>
            <tr>
              <th>ショップ備考欄</th>
              <td colspan="3">{{ b.booking_shop_comment }}</td>
              <td><router-link :to="{ name: 'BookingDetailPage', params: { id: b.id} }"><v-btn rounded color="primary" dark id="booking-edit-button">編集</v-btn></router-link></td>
              <td><v-btn rounded color="primary" dark @click="delete_booking(b.id)">削除</v-btn></td>
            </tr>
          </tbody>
        </table>
      </v-row>
  
    </v-container>
    <BookingNew ref="dlg" v-show="noneArea"></BookingNew>
  </v-app>
</template>

<script>
import axios from 'axios'
import dayjs from 'dayjs'
import 'dayjs/locale/ja'
import qs from 'qs'
import vuejsDatepicker from "vuejs-datepicker";
import BookingNew from './BookingNew.vue';


export default {
  components: {
    'vuejs-datepicker':vuejsDatepicker,
    BookingNew,
  },
  data: function () {
    return {
      bookings: [],
      noneArea: false,
      DatePickerFormat: 'yyyy-MM-dd',
      query: {
        last_name_eq: null,
        mobilephone_eq: null,
        start_date_time: null
      },
      menu: false
    }
  },
  created: function () {
    this.search()
  },
  methods: {
    // notify: function(msg){
    //   this.$notify({
    //     type: 'error',
    //     title: 'Error',
    //     message: msg
    //   });
    // },
    delete_booking: function(id){
      if(confirm('削除してよろしいですか？'))
      axios.delete(`/api/v1/bookings/${id}`)
        // paramsSerializer: function(params) {
        //   return qs.stringify(params, {arrayFormat: 'brackets'})
        // }
      .then(response => {
        alert("削除が完了しました");
        this.$router.go({path: '/employees/bookings/', force: true});
        })
      .catch((error) => {
        console.log(error);
      })
    },
    showEvent() {
      this.$refs.dlg.isDisplay = true
    },
    search: function(){
      axios.get('/api/v1/bookings', {
        params: {
          q: this.query
        },
        paramsSerializer: function(params) {
          return qs.stringify(params, {arrayFormat: 'brackets'})
        }
      })
      .then(response => (this.bookings = response.data))
      .then(function(bookings) {
        bookings.map(function(booking) {
          booking.start_date_time = dayjs(booking.start_date_time).format('YYYY/M/D H:mm');
          booking.end_date_time = dayjs(booking.end_date_time).format('YYYY/M/D H:mm');
          booking.start_last_booking = dayjs(booking.start_last_booking).format('YYYY/M/D H:mm');
          booking.end_last_booking = dayjs(booking.end_last_booking).format('YYYY/M/D H:mm');
          booking.menus.menu_and_price = `${booking.menus.menu_name}`.replace(',',' / ');
          let sum_price = booking.menus.menu_price;
          let total = sum_price.reduce(function(sum, element){
            return sum + element;
          },0);
          booking.menus.menu_sum_price = `${total.toLocaleString('ja-JP')}円`;
        });
      })
      .catch((error) => {
        console.log(error);
      })
    },
    reset: function() {
      this.query.last_name_eq = null;
      this.query.mobilephone_eq = null;
      this.query.start_date_time = null;
      this.$router.go({path: '/employees/bookings/', force: true});
    }
  }

}
</script>

<style scoped>
.top-margin {
  margin-top:56px;
}

p {
  font-size: 2em;
  text-align: center;
}

.booking_index th {
  background-color: #f5f5f5;
  vertical-align: middle;
}

.booking_index td {
  vertical-align: middle;
}

</style>
