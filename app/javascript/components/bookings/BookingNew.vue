<template>
  <v-app>
    <v-dialog v-model="isDisplay" @input="v => v || window_close()" width="90%">
    <v-card>
      <v-row justify="center" align-content="center" class="ml-5 mr-5 mb-3">
      <div class="col-md-12 mx-5">
        <div class="row mt-5">
          <div :class="navigationCss(1)">STEP1 予約日時選択</div>
          <div :class="navigationCss(2)">STEP2 顧客/ペット選択</div>
          <div :class="navigationCss(3)">STEP3 メニュー選択/特記入力</div>
          <div :class="navigationCss(4)">STEP4 確認画面</div>
        </div>
      </div>
      </v-row>
      <!-- <div class="col-md-6 offset-md-3 mb-5">
        <div><pre>●開始時間：{{ params.start_date_time }}●</pre></div>
        <div><pre>●終了時間：{{ params.end_date_time }}●</pre></div>
        <div><pre>●ペットID：{{ params.pet_id }}●</pre></div>
        <div><pre>●ペット犬種：{{ breed }}●</pre></div>
        <div><pre>●メニューID：{{ params.menu_id }}●</pre></div>
        <div><pre>●今回の予約に関するコメント：{{ params.booking_shop_comment }}</pre></div>
      {{ pets }}
      </div> -->

      <div class="col-md-10 offset-md-1" v-if="page==1">
        <div class="form-group">
          <booking-on-calender v-model="params.name" @set-time-event-child="parentMethod"></booking-on-calender>
        </div>
      </div>

      <div class="col-md-8 offset-md-2" v-if="page==2">
        <div class="form-group">
          <v-form :model="query" class="col-8 mx-auto mt-7">
          <v-text-field label="名前(姓)" v-model="query.last_name_eq" placeholder="名前(姓)" name="new-booking-name"></v-text-field>
          <v-text-field label="携帯電話" v-model="query.mobilephone_eq" placeholder="携帯電話"></v-text-field>
          </v-form>
        </div>
        <v-col align="center">
          <v-btn rounded color="primary" large dark class="mt-2 pr-10 pl-10" @click="search">　検索　</v-btn>
        </v-col>
        <div v-if="pets.length >= 1">
          <table class="table table-bordered col-12 booking_index" outlined v-for="pet in pets" :key="pet.pet_id">
            <tr>
              <td>{{ pet.name }} 　犬種：{{ pet.pet_breed }}</td>
              <td rowspan="2" width="100">
                <v-btn rounded color="primary" dark @click="pet_select(pet.pet_id, pet.pet_breed, pet.name)">選択</v-btn></td>
            </tr>
            <tr>
              <td>{{ pet.pet_comment }}</td>
            </tr>
          </table>
        </div>
        <div v-else-if="pets.length === 1">
          <table class="table table-bordered col-12 booking_index" outlined>
            <tr>
              <td>{{ pets.first.name }} 　犬種：{{ pets.first.pet_breed }}</td>
              <td rowspan="2" width="100">
                <v-btn rounded color="primary" dark @click="pet_select(pets.first.pet_id, pets.first.pet_breed, pets.first.name)">　選択　</v-btn>
              </td>
            </tr>
            <tr>
              <td>{{ pets.first.pet_comment }}</td>
            </tr>
          </table>
        </div>
        <div v-else>
        </div>
      </div>

      <div class="col-md-8 offset-md-2" v-if="page==3">
        <div class="mt-5 mb-2">メニュー選択</div>
         <!-- menu_id_array: {{ menu_id_array }}

        menu_id: {{params.menu_id}}
        menu_name: {{menu_name_array}} -->
        <div class="form-group">
          <table class="table table-bordered col-12 booking_index" outlined v-for="menu in menus" :key="menu.id">
            <tr>
              <td>{{ menu.menu_name }} [{{ menu.breed }}]　</td>
              <td rowspan="2" width="100" class="checkbox-center">
     
                  <input type="checkbox" v-model="menu_id_array" v-bind:value="{id: menu.id, menu_name: menu.menu_name}" class="new-booking-menu-select">
              </td>
            </tr>
            <tr>
              <td>金額：{{ menu.price.toLocaleString() }}円　作業時間目安：{{ menu.working_hours }}</td>
            </tr>
          </table>

          
          <div class="mt-5 mb-2">特記事項</div>
          <div>
            <v-textarea
              v-model="params.booking_shop_comment"
              clearable
              outlined
              label="今回の予約に関する特記事項"
              value="今回の予約に関する特記事項"
              color="teal"
              id="new-booking-comment"
            >
            </v-textarea>
          </div>
        <v-col align="center">
         <v-btn rounded color="primary" dark @click="menu_select_done()">　確認画面　</v-btn>
        </v-col>
        </div>
      </div>


             


      <div class="col-12" align="center" justify="center" align-content="center" v-if="page==4">
        <!-- {{selected_menu_name}} -->
        予約内容の確認

        <!-- {{menus}} -->
<!-- 
        ---------
        {{params.menu_id}} -->
        <div class="form-group" align="center">

           <div class="col-md-8 mb-3 mx-auto">
              <div>開始時間：{{ params.start_date_time }}</div>
              <div>終了時間：{{ params.end_date_time }}</div>
              <div>顧客名：{{ cust_pet_name }}</div>
              <div>ペット犬種：{{ breed }}</div>
              <div>メニュー：{{ menu_name_array.toString() }}</div>
              <div>今回の予約に関するコメント：{{ params.booking_shop_comment }}</div>
            </div>
            <v-col align="center">
             <v-btn rounded color="primary" dark @click="create_bookings()">　送信　</v-btn>
            </v-col>
        </div>
      </div>
      <v-col align="center">
        <v-btn class="mb-5" outlined color="blue-grey" @click="window_close()">キャンセル</v-btn>
      </v-col>
<!-- 
      <div class="col-md-4 offset-md-4 pt-5">
        <button class="btn btn-secondary float-right"
        type="button" v-if="page<4" @click="next">次へ</button>
        <button class="btn btn-secondary float-right"
        type="button" v-if="page==4" @click="submit">送信する</button>
        <button class="btn btn-secondary float-right"
        type="button" v-if="page>1" @click="prev">戻る</button>
      </div> -->

    </v-card>
    </v-dialog>
  </v-app>
</template>

<script>
import axios from 'axios'
import qs from 'qs'
import BookingOnCalender from './BookingOnCalender.vue';
import dayjs from 'dayjs'
import 'dayjs/locale/ja'


export default {
    components: { BookingOnCalender },
    data: function () {
      return {
        page: 1,
        params: {
        start_date_time: '',
        end_date_time: '',
        customer_id: '',
        pet_id: '',
        menu_id: [],
        booking_shop_comment: '',
        },
        query: {
        last_name_eq: null,
        mobilephone_eq: null
        },
        menu_id_array: [],
        pets: [],
        menus: [],
        start_end_time: '',
        breed: '',
        cust_pet_name: '',
        isDisplay: false,
        selected_menu_name: [],
        menu_name_array: [],
      }
    },
   
    methods: {
      next() {
        this.page++;
      },
      prev() {
        this.page--;
      },
      window_close() {
        Object.assign(this.$data, this.$options.data.call(this));
      },
      submit() {
        // const url = 'http://localhost:3000/';
        // axios.post(url, this.params)
        // .then((response) => {

        // });
      },
      navigationCss(targetPage) {
        if(this.page === targetPage) {
          return ['col-3', 'text-center', 'text-white', 'bg-info', 'p-2'];
        }
        return ['col-3', 'text-center', 'text-secondary', 'p-2'];
      },
      parentMethod(payload) {
        this.params.start_date_time = payload.start;
        this.params.end_date_time = payload.end;
        this.next();
      },
      pet_select(pet_id, breed, cust_pet_name) {
        this.params.pet_id = pet_id;
        this.breed = breed;
        this.cust_pet_name = cust_pet_name;
        this.menu_all(breed);
        this.next();
      },
      menu_select_done() {

        this.params.menu_id  = this.menu_id_array.map(item => item["id"])
        this.menu_name_array  = this.menu_id_array.map(item => item["menu_name"])

        // this.params.menu_id = array_column(this.menu_id_array, "id");
        // this.menu_name_array = array_column(this.menu_id_array, "menu_name");

        // メニュIDの配列がくる
        // menusハッシュの中でメニュIDが含まれる配列のmenu_nameを配列で格納する

        // railsで書くとしたら
        // menusをeachで回す。その中でfindで検索。該当したらnameをpushする。
       
          
          // const menu_all = JSON.stringify(ary)this.menus;
          // const menu_array = menu;

          // console.log('*menu_all' + menu_all);
          // console.log('*menu_array' + menu_array);

        //   const result = {};

        //   for(var key of object.keys(menu_all)){
        //     for(var i of menu_array){
        //       if(key == i) {
        //         result[key] = menu_all[key];
        //         break;
        //       }
        //     }
        //   }
   

        // this.selected_menu_name = result;


        this.next();
      },
      create_bookings() {
      axios.post('/api/v1/bookings', {
        params: this.params
        
      })
      .then(response => {
        alert("登録が完了しました");
        this.$router.go({path: '/employees/bookings/', force: true});
        })
      .catch((error) => {
        console.log(error);
      })
      },
      menu_all: function(breed){
        axios.get('/api/v1/bookings/menus', {
        params: {
          breed: breed
        }
      })
      .then(response => (this.menus = response.data))
      .then(function(menus) {
        menus.map(function(menu) {
        menu.working_hours = dayjs(menu.working_hours).format('H:mm');
        });
      })


      },
      search: function(){
      axios.get('/api/v1/bookings/new', {
        params: {
          q: this.query
        },
        paramsSerializer: function(params) {
          return qs.stringify(params, {arrayFormat: 'brackets'})
        }
      })
      .then(response => (this.pets = response.data))
      .catch((error) => {
        console.log(error);
      })
    }
    }
  };
</script>

<style scoped>
.booking_index th {
  background-color: #f5f5f5;
  vertical-align: middle;
  font-size: 13px;
}

.booking_index td {
  vertical-align: middle;
  font-size: 14px;
}

.checkbox-center {
  justify-content: center;
  text-align: center;
  vertical-align: middle;
}

</style>
