<template>
  <v-app id="app" class="top-margin">
    <div v-if="this.p.customer != null">
      <div class="cyan lighten-3 pt-4 pb-2">
        <span class="ml-10">電子カルテ詳細</span>
      </div>
      <v-row justify="center" align-content="center" class="text-caption">
        <table class="table table-bordered col-8 pet-detail" style="border-left:none; border-top:none;">

          <colgroup v-for="n of 10" :key="n">
            <col class="col-width">
          </colgroup>

          <tbody>
            <tr>
              <td v-for="n of 9" :key="n" colspan="1" style="border:none;"></td>
            </tr>

            <tr>
              <td colspan="4" class="table-label" style="border:none;">顧客情報</td>
            </tr>

            <tr>
              <th colspan="2">ふりがな</th>
              <td colspan="8" >{{ p.customer.furigana_last_name }} {{ p.customer.furigana_first_name }}様</td>
            </tr>

            <tr>
              <th colspan="2">顧客名</th>
              <td colspan="8">{{ p.customer.last_name }} {{ p.customer.first_name }}様</td>
            </tr>

            <tr>
              <th colspan="2" rowspan="2">住所</th>
              <td colspan="8" style="border-bottom:none;">{{ p.customer.postcode }}</td>
            </tr>

            <tr>
              <td colspan="8" style="border-top:none;">{{ p.customer.address }}</td>
            </tr>

            <tr>
                <th colspan="2">ご連絡先</th>
                <td colspan="4" style="border-right:none;">ご自宅 {{ p.customer.homephone }}</td>
                <td colspan="4" style="border-left:none;">携帯電話 {{ p.customer.mobilephone }}</td>
            </tr>
          </tbody>

          <tbody>
            <tr>
              <td colspan="4" class="table-label" style="border:none;">申し送り備考欄</td>
            </tr>

            <tr>
              <td colspan="10" >{{p.pet.pet_comment}}</td>
            </tr>
          </tbody>
          
          <tbody>
            <tr style="border:none;">
              <td colspan="4" class="table-label" style="border:none;">過去の予約履歴</td>
            </tr>

            <tr>
              <th colspan="3">日時</th>
              <th colspan="4">メニュー</th>
              <th colspan="3">価格</th>
            </tr>
            
            <tr v-for="menus in p.menus" :key="menus.id">
                <td colspan="3">{{menus.start_last_booking | moment}}</td>
                <td colspan="4"><span v-for="m_menu_name in menus.menu_name" :key="m_menu_name.id">{{m_menu_name}}<br></span></td>
                <td  colspan="3"><span v-for="m_price in menus.price" :key="m_price.id">¥{{m_price.toLocaleString()}}円<br></span></td>
            </tr>
          </tbody>

          <tbody>
            <tr>
              <td colspan="4" class="table-label" style="border:none;">ペット一覧</td>
            </tr>

            <tr>
              <th colspan="3">ペットのお名前</th>
              <th colspan="4">年齢</th>
              <th colspan="3">犬種</th>
            </tr>

            <tr v-for="pets in p.pets" :key="pets.id">
              <td colspan="3">{{pets.pet_name}}</td>
              <td colspan="4">{{pets.birthday | birthday}}歳</td>
              <td colspan="3">{{pets.breed}}</td>
            </tr>
          </tbody>
        </table>

        <div class="pet-images col-8">
          <div class="pet-image">
            
            <div class="big-image">
              <img :src="imgMain">
            </div>

            <div class ="small-images">

              <div class="small-image" @click="imgChange(0)">
                <img :src="p.pet.images[0]">
              </div>

              <div class="small-image" @click="imgChange(1)">
                <img :src="p.pet.images[1]">
              </div>

              <div class="small-image" @click="imgChange(2)">
                <img :src="p.pet.images[2]">
              </div>

              <div class="small-image" @click="imgChange(3)">
                <img :src="p.pet.images[3]">
              </div>

            </div>

          </div>

          <div class="pet-image-memo">
            <p>写真の手書きメモ</p>
            <textarea class="memo-form"></textarea>
          </div>

        </div>


        <table class="table table-bordered col-8 pet-detail" style="border-left:none; border-top:none;">

          <colgroup v-for="n of 10" :key="n">
            <col class="col-width">
          </colgroup>

          <tbody>
            <tr>
              <td v-for="n of 9" :key="n" colspan="1" style="border:none;"></td>
            </tr>

            <tr>
              <td colspan="4" class="table-label" style="border:none;">ペット情報</td>
            </tr>

            <tr>
              <th colspan="2">ペットのお名前</th>
              <td colspan="8">{{p.pet.pet_name}}</td>
            </tr>

            <tr>
              <th colspan="2">犬種</th>
              <td colspan="8">{{p.pet.breed}}</td>
            </tr>

            <tr>
              <th colspan="2">お誕生日</th>
              <td colspan="2">{{p.pet.birthday | moment}}</td>
              <th colspan="2">性別</th>
              <td colspan="2" style="border-right:none;"><label>♂ <input type="checkbox" v-model="checkGender1" :disabled= true></label></td>
              <td colspan="2" style="border-left:none;"><label>♀ <input type="checkbox" v-model="checkGender2" :disabled= true></label></td>
            </tr>

            <tr>
              <th colspan="2">一番最近の<br>ワクチン接種日</th>
              <td colspan="2">{{p.pet.vaccine_day | moment}}</td>
              <th colspan="2">かかりつけの<br>病院名</th>
              <td colspan="4">{{p.pet.hospital_name}}</td>
            </tr>
          </tbody>
        </table>

        <div class="pet-detail-form col-8">
          <div  colspan="8" class="pet-detail-item">
            <label>
              ・ノミ・ダニはいますか？ ※もしいた場合、追加料金¥1,000円をいただく場合がございます。
            </label>
            <div class="double-check"> 
              <label><input type="checkbox" v-model="checkDermatitis1" :disabled= true> なし</label>
              <label><input type="checkbox" v-model="checkDermatitis2" :disabled= true> あり</label>
            </div>
            <textarea class="item-form" v-model="dermatitisComment" :disabled= true></textarea>
          </div>
          <div class="pet-detail-item">
            <label>
              ・皮膚炎(かゆみ、湿疹など)はありますか？
            </label>
            <div class="double-check">
              <label><input type="checkbox" v-model="checkDisease1" :disabled= true> なし</label>
              <label><input type="checkbox" v-model="checkDisease2" :disabled= true> あり</label>
            </div>
            <textarea class="item-form" v-model="diseaseComment" :disabled= true></textarea>
          </div>

          <div class="pet-detail-item">
            <label>
              ・持病(てんかんなど)はありますか？
            </label>
            <div class="double-check">
              <label><input type="checkbox" v-model="checkFlea1" :disabled= true> なし</label>
              <label><input type="checkbox" v-model="checkFlea2" :disabled= true> あり</label>
            </div>
              <textarea class="item-form" v-model="fleaComment" :disabled= true></textarea>
          </div>
        </div>

        <table class="table table-bordered col-8 pet-detail" style="border-left:none; border-top:none;">

          <colgroup v-for="n of 10" :key="n">
            <col class="col-width">
          </colgroup>

          <tbody>
            <tr>
              <td v-for="n of 9" :key="n" colspan="1" style="border:none;"></td>
            </tr>

            <tr>
              <th colspan="1" rowspan="5" >ア<br>ン<br>ケ<br>|<br>ト</th>
              <td colspan="9" style="border-bottom:none;">ペットサロンCOROTIAをどこで知りましたか？</td>
            </tr>

            <tr>
              <td colspan="3" style="border:none;"><label><input type="checkbox" v-model="checkEnquete1" :disabled= true> インターネット</label></td>
              <td colspan="3" style="border:none;"><label><input type="checkbox" v-model="checkEnquete2" :disabled= true> お店の前を通って</label></td>
              <td colspan="4" style="border:none;"></td>
            </tr>

            <tr>
              <td colspan="3" style="border:none;"><label><input type="checkbox" v-model="checkEnquete3" :disabled= true> チラシ告知</label></td>
              <td colspan="3" style="border:none;"><label><input type="checkbox" v-model="checkEnquete4" :disabled= true> ご紹介</label></td>
              <td colspan="4" style="border:none;"><span v-if="checkEnquete4 == true ">{{p.pet.pet_name}}様</span></td>
            </tr>

            <tr>
              <td colspan="9" style="border-bottom:none;">トリマーに伝えておきたいことがありましたらご記入ください</td>
            </tr>

            <tr>
              <td colspan="9" style="border-top:none;"><textarea class="item-form" v-model="KnowShopComment" :disabled= true></textarea></td>
            </tr>
          </tbody>
        </table>

        <div class="col-8">
          <div class="text-right">
          <v-icon
            large
            color="primary"
            class="mr-2"
            @click="editPet()"
          >
            mdi-pencil
          </v-icon>  
          <v-icon
            large
            color="error"
            @click="deleteItem(item)"
          >
            mdi-delete
          </v-icon>
          </div>
        </div>
        
      </v-row>
    </div>
  </v-app>
</template>

<script>
// axiosを読み込む
import axios from 'axios';
import moment from 'moment';


export default {
  data() {
    return {
      p: [],
      imgSrc: ""
    }
  },
  methods: {
    imgChange(num){
      this.imgSrc = this.p.pet.images[num]
    },
    editPet(){
      console.log(this.p.pet.id)
      this.$router.push({path:`/employees/charts/edit/${this.p.pet.id}`});
    }
  },
  computed: {
    imgMain(){
      return this.imgSrc
    },
    checkGender1(){
      if (this.p.pet.gender == "オス") {
        return true
      }else{
        return false
      }
    },
    checkGender2(){
      if (this.p.pet.gender == "メス") {
        return true
      }else{
        return false
      }
    },
    checkDermatitis1(){
      if (this.p.pet.dermatitis == false) {
        return true
      }else{
        return false
      }
    },
    checkDermatitis2(){
      if (this.p.pet.dermatitis == true) {
        return true
      }else{
        return false
      }
    },
    checkDisease1(){
      if (this.p.pet.disease == false) {
        return true
      }else{
        return false
      }
    },
    checkDisease2(){
      if (this.p.pet.disease == true) {
        return true
      }else{
        return false
      }
    },
    checkFlea1(){
      if (this.p.pet.flea == false) {
        return true
      }else{
        return false
      }
    },
    checkFlea2(){
      if (this.p.pet.flea == true) {
        return true
      }else{
        return false
      }
    },
    dermatitisComment(){
      return this.p.pet.dermatitis_comment
    },
    diseaseComment(){
      return this.p.pet.disease_comment
    },
    fleaComment(){
      return this.p.pet.flea_comment
    },
    checkEnquete1(){
      if (this.p.enquete != null) {
        if (this.p.enquete.know_shop == 1) {
          return true
        }else{
          return false
        }
      }
    },
    checkEnquete2(){
      if (this.p.enquete != null) {
        if (this.p.enquete.know_shop == 2) {
          return true
        }else{
          return false
        }
      }
    },
    checkEnquete3(){
      if (this.p.enquete != null) {
        if (this.p.enquete.know_shop == 3) {
          return true
        }else{
          return false
        }
      }
    },
    checkEnquete4(){
      if (this.p.enquete != null) {
        if (this.p.enquete.know_shop == 4) {
          return true
        }else{
          return false
        }
      }
    },
    KnowShopComment(){
      if (this.p.enquete != null){
        return this.p.enquete.know_shop_comment
      }
    }
  },

  mounted() {
    axios
      .get(`/api/v1/pets/${this.$route.params.id}.json`)
      .then(response => (this.p = response.data))
      .then(response => (this.imgSrc = response.pet.images[0]))
  },
  filters: {
    moment: function (data) {
      return moment(data).format('YYYY年MM月DD日')
    },
    birthday: function (data) {
      const birthday = {
        year: moment(data).format('YYYY'),
        month: moment(data).format('MM'),
        day: moment(data).format('DD')
      };
      var today = new Date()
      var thisYearBirthday = new Date(today.getFullYear(), birthday.month -1, birthday.day);
      var age = today.getFullYear() - birthday.year;
      if (today < thisYearBirthday){
        return age - 1
      }else{
        return age 
      }
    }
  }

}

</script>

<style scoped>
.top-margin {
  margin-top:56px;
}
.col-width{
  width:10%;
}
.table-label{
  font-weight:bold;
}
.pet-detail th {
  background-color: #f5f5f5;
  vertical-align: middle;
  text-align: center;
}

.pet-detail td {
  vertical-align: middle;
  text-align: left;
}
.pet-detail-item{
  width:100%;
}
.item-form{
  width:100%;
  border:1px solid black;
  border-radius: 5px;
}
.pet-images{
  display:flex;
}
.pet-image {
  width:60%;
}
.small-images{
  width:100%;
  display:flex;
  justify-content: space-around;
}
.small-image{
  max-width:22%;
  width:100%;
  height:auto;
  position:relative;
  border: 2px solid black;
  border-radius:2px;
  background-color:white;
}
.small-image:before{
  content:"";
  display:block;
  padding-top:100%;
}
.small-image img{
  width:100%;
  height:100%;
  object-fit: contain;
  border-radius:2px;
  position:absolute;
  top:50%;
  left:50%;
  transform: translate(-50%,-50%);
}
.pet-image-memo{
  width:50%;
  height:auto;
  background-color: rgb(255, 248, 246);
  border:1px solid black;
}
.pet-image-memo p{
  height:10%
}
.memo-form{
  width:100%;
  height:85%;
}
.big-image{
  max-width:80%;
  width:100%;
  height:auto;
  position:relative;
  border: 2px solid black;
  border-radius:2px;
  background-color:white;
  margin: 0 auto;
  margin-bottom:30px;
}
.big-image:before{
  content:"";
  display:block;
  padding-top:100%;
}
.big-image img{
  width:100%;
  height:100%;
  object-fit: contain;
  border-radius:2px;
  position:absolute;
  top:50%;
  left:50%;
  transform: translate(-50%,-50%);
}
</style>