<template>
  <v-app>
      <v-dialog v-model="isDisplay" @input="v => v || window_close()" width="50%">
          <v-card>
              <v-card>
                  
                  <v-card-actions justify="center">
                        <v-row justify="center">
                            <v-col cols="12">
                             <!-- value.date: {{ value.date }}
                             開始時間： {{ value_start_time }}
                             終了時間： {{ value_end_time }} -->
                             <div v-if="page==1" class="btn-style">
                                <!-- <v-btn @click="value_start_time_method('07:00')">7:00〜</v-btn>
                                <v-btn @click="value_start_time_method('07:30')">7:30〜</v-btn> -->
                                <v-col cols=12 lg=12 md=12 sm=12 align="center" class="pt-8">開始時間選択</v-col>
                                <v-container class="d-flex justify-content-center">
                                    <v-btn class="mr-3" width="100" outlined color="indigo" @click="value_start_time_method('07:00')">7:00〜</v-btn>
                                    <v-btn class="mr-3" width="100" outlined color="indigo" @click="value_start_time_method('07:30')">7:30〜</v-btn>
                                    <v-btn class="mr-3" width="100" outlined color="indigo" @click="value_start_time_method('08:00')">8:00〜</v-btn>
                                    <v-btn class="justifiy-content-center" width="100" outlined color="indigo" @click="value_start_time_method('08:30')">8:30〜</v-btn>
                                </v-container>
                                <v-container class="d-flex justify-content-center">
                                    <v-btn class="mr-3" width="100" outlined color="indigo" @click="value_start_time_method('09:00')">9:00〜</v-btn>
                                    <v-btn class="mr-3 time-rspec" width="100" outlined color="indigo" @click="value_start_time_method('09:30')">9:30〜</v-btn>
                                    <v-btn class="mr-3" width="100" outlined color="indigo" @click="value_start_time_method('10:00')">10:00〜</v-btn>
                                    <v-btn class="justifiy-content-center" width="100" outlined color="indigo" @click="value_start_time_method('10:30')">10:30〜</v-btn>
                                </v-container>
                                <v-container class="d-flex justify-content-center mb-5">
                                    <v-btn class="mr-3" width="100" outlined color="indigo" @click="value_start_time_method('11:00')">11:00〜</v-btn>
                                    <v-btn class="justifiy-content-center" width="100" outlined color="indigo" @click="value_start_time_method('11:30')">11:30〜</v-btn>
                                </v-container>
                                
                                <v-container class="d-flex justify-content-center">
                                    <v-btn class="mr-3" width="100" outlined color="indigo" @click="value_start_time_method('12:00')">12:00〜</v-btn>
                                    <v-btn class="mr-3" width="100" outlined color="indigo" @click="value_start_time_method('12:30')">12:30〜</v-btn>
                                    <v-btn class="mr-3" width="100" outlined color="indigo" @click="value_start_time_method('13:00')">13:00〜</v-btn>
                                    <v-btn class="justifiy-content-center" width="100" outlined color="indigo" @click="value_start_time_method('13:30')">13:30〜</v-btn>
                                </v-container>
                                <v-container class="d-flex justify-content-center">
                                    <v-btn class="mr-3" width="100" outlined color="indigo" @click="value_start_time_method('14:00')">14:00〜</v-btn>
                                    <v-btn class="mr-3" width="100" outlined color="indigo" @click="value_start_time_method('14:30')">14:30〜</v-btn>
                                    <v-btn class="mr-3" width="100" outlined color="indigo" @click="value_start_time_method('15:00')">15:00〜</v-btn>
                                    <v-btn class="justifiy-content-center" width="100" outlined color="indigo" @click="value_start_time_method('15:30')">15:30〜</v-btn>
                                </v-container>
                                <v-container class="d-flex justify-content-center">
                                    <v-btn class="mr-3" width="100" outlined color="indigo" @click="value_start_time_method('16:00')">16:00〜</v-btn>
                                    <v-btn class="mr-3" width="100" outlined color="indigo" @click="value_start_time_method('16:30')">16:30〜</v-btn>
                                    <v-btn class="mr-3" width="100" outlined color="indigo" @click="value_start_time_method('17:00')">17:00〜</v-btn>
                                    <v-btn class="justifiy-content-center" width="100" outlined color="indigo" @click="value_start_time_method('17:30')">17:30〜</v-btn>
                                </v-container>
                                <v-container class="d-flex justify-content-center mb-5">
                                    <v-btn class="justifiy-content-center" width="100" outlined color="indigo" @click="value_start_time_method('18:00')">18:00〜</v-btn>
                                </v-container>
                               
                                <v-container class="d-flex justify-content-center">
                                    <v-btn class="mr-3" width="100" outlined color="indigo" @click="value_start_time_method('18:30')">18:30〜</v-btn>
                                    <v-btn class="mr-3" width="100" outlined color="indigo" @click="value_start_time_method('19:00')">19:00〜</v-btn>
                                    <v-btn class="mr-3" width="100" outlined color="indigo" @click="value_start_time_method('19:30')">19:30〜</v-btn>
                                    <v-btn class="justifiy-content-center" width="100" outlined color="indigo" @click="value_start_time_method('20:00')">20:00〜</v-btn>
                                </v-container>
                                <v-container class="d-flex justify-content-center">
                                    <v-btn class="mr-3" width="100" outlined color="indigo" @click="value_start_time_method('20:30')">20:30〜</v-btn>
                                    <v-btn class="mr-3" width="100" outlined color="indigo" @click="value_start_time_method('19:00')">19:00〜</v-btn>
                                    <v-btn class="mr-3" width="100" outlined color="indigo" @click="value_start_time_method('19:30')">19:30〜</v-btn>
                                    <v-btn class="justifiy-content-center" width="100" outlined color="indigo" @click="value_start_time_method('20:00')">20:00〜</v-btn>
                                </v-container>
                                <v-container class="d-flex justify-content-center mb-5">
                                    <v-btn class="justifiy-content-center" outlined color="indigo" @click="value_start_time_method('20:30')">20:30〜</v-btn>
                                </v-container>
                               
                                <v-container class="d-flex justify-content-center">
                                    <v-btn class="mr-3" width="100" outlined color="indigo" @click="value_start_time_method('21:00')">21:00〜</v-btn>
                                    <v-btn class="mr-3" width="100" outlined color="indigo" @click="value_start_time_method('21:30')">21:30〜</v-btn>
                                    <v-btn class="mr-3" width="100" outlined color="indigo" @click="value_start_time_method('22:00')">22:00〜</v-btn>
                                    <v-btn class="justifiy-content-center" outlined color="indigo" @click="value_start_time_method('22:30')">22:30〜</v-btn>
                                </v-container>

                                <!-- 開始時間: {{ value_start_time }} -->
                             </div>
                     
                            <div class="col-md-6 offset-md-3" v-if="page==2">
                            <v-col cols=12 lg=12 md=12 sm=12 align="center" justify="center" class="pt-8">予約枠選択</v-col>

                    
                                <v-col align="center"><v-btn width="100" outlined color="indigo" @click="value_end_time_method('30')">30分</v-btn></v-col>
                                <v-col align="center"><v-btn width="100" outlined color="indigo" @click="value_end_time_method('60')">1時間</v-btn></v-col>
                                <v-col align="center"><v-btn width="100" outlined color="indigo" @click="value_end_time_method('90')">1時間30分</v-btn></v-col>
                                <v-col align="center"><v-btn width="100" outlined color="indigo" @click="value_end_time_method('120')">2時間</v-btn></v-col>
                                <v-col align="center"><v-btn width="100" outlined color="indigo" @click="value_end_time_method('150')">2時間30分</v-btn></v-col>
                                <v-col align="center"><v-btn width="100" outlined color="indigo" @click="value_end_time_method('180')">3時間00分</v-btn></v-col>
                                <v-col align="center"><v-btn width="100" outlined color="indigo" @click="value_end_time_method('210')">3時間30分</v-btn></v-col>
                                <v-col align="center"><v-btn width="100" outlined color="indigo" @click="value_end_time_method('240')">4時間</v-btn></v-col>
                                <v-col align="center"><v-btn width="100" outlined color="indigo" @click="value_end_time_method('270')">4時間30分</v-btn></v-col>
                                <v-col align="center"><v-btn width="100" outlined color="indigo" @click="value_end_time_method('300')">5時間</v-btn></v-col>
            


                                <!-- w_time: {{ s_time }}<br><br>
                                終了時間: {{ value_end_time }} -->
                            
                                <!-- <v-btn @click="work_time">確定</v-btn> -->
                             
                                 <!-- <v-btn @click="window_close()">キャンセル</v-btn> -->
                            
                            </div>
                            </v-col>
                        </v-row>
                        
                  </v-card-actions>
              </v-card>
            </v-card>
      </v-dialog>
  </v-app>
</template>

<script>
// import axios from 'axios'

import moment from 'moment';

export default({
    props: {
        value: {
            type: Object,
            default: []
            }, 
    },
    data: function() {
        return {
            page: 1,
            isDisplay: false,
            value_start_time: '',
            s_time: '',
            value_end_time: '',
            end_time: '',
            hash_time: '',
        }
    },
    methods: {
        work_time() {
            const hash = {}
            hash.start = this.value_start_time
            hash.end = this.value_end_time
            this.hash_time = hash
            this.isDisplay = false
            this.$emit('set-time-event', this.hash_time)
           
        },
        window_close() {
            this.page = 1;
            this.value_start_time = '';
            this.s_time = '';
            this.value_end_time = '';
            this.end_time = '';
            this.hash_time = '';
            this.isDisplay = false;
        },
        value_start_time_method(val) {
            const time = this.value.date + " " + val;
            this.next();
            return this.value_start_time = time;
        },
        value_end_time_method(val) {
            const end = moment(this.value_start_time);
            const t_end = end.add(val, 'm').format("YYYY-MM-DD HH:mm");
            this.value_end_time = t_end;
            this.work_time();

        },
        next() {
            this.page++;
        },
        prev() {
            this.page--;
        },
        navigationCss(targetPage) {
            if(this.page === targetPage) {
            return ['col-4', 'text-center', 'text-white', 'bg-info', 'p-2'];
            }
            return ['col-4', 'text-center', 'text-secondary', 'p-2'];
        },
    }
    

})
</script>
