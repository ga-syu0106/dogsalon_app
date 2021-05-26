<template>
  <v-app id="app" class="top-margin">
    <div class="cyan lighten-3 pt-4 pb-2">
      <span class="ml-10">メニュー一覧</span>
    </div>
    
    <v-row justify="center" align-content="center" class="text-caption">
      <v-col cols="8">
        <v-card>
          <v-card-title>
            Menu一覧
            <v-spacer></v-spacer>
            <v-text-field
              v-model="search"
              append-icon="mdi-magnify"
              label="Search"
              class="mb-3"
              single-line
              hide-details
            ></v-text-field>
          </v-card-title>
      
          <v-dialog
            v-model="dialog"
            max-width="800px"
          >
            <template v-slot:activator="{ on, attrs }">
              <v-btn
                color="primary"
                dark
                class="mb-3 mx-2"
                v-bind="attrs"
                v-on="on"
              >
                新規メニュー追加
              </v-btn>
            </template>
        
            <v-card>
              <v-card-title>
                <span class="headline">{{ formTitle }}</span>
              </v-card-title>
              <span v-if="errors.length" class="error_text">
                <ul>
                  <li v-for="error in errors" :key="error">{{ error }}</li>
                </ul>
              </span>

              <v-card-text>
                <v-container>
                  <v-row>
                    <v-col
                      cols="12"
                      sm="6"
                      md="5"
                    >
                      <v-select
                        v-model="editedItem.menu_name"
                        :items="menu_items"
                        :menu-props="{ maxHeight: '400' }"
                        label="メニュー"
                        hint="メニューを選択してください"
                        persistent-hint
                      ></v-select>
                    </v-col>

                    <v-col
                      cols="12"
                      sm="6"
                      md="5"
                    >
                      <v-select
                        v-model="editedItem.breed"
                        :items="items"
                        :menu-props="{ maxHeight: '400' }"
                        label="犬種"
                        hint="犬種を選択してください"
                        persistent-hint
                      ></v-select>
                    </v-col>

                    <v-col
                      cols="12"
                      sm="6"
                      md="5"
                    >
                      <v-text-field
                        v-model ="editedItem.price"
                        label="値段(円)"
                        type = "number"
                        min ="1"
                      ></v-text-field>
                    </v-col>

                    <v-col
                      cols="12"
                      sm="6"
                      md="5"
                    >
                      <v-text-field
                        v-model="editedItem.working_hours"
                        label="所用時間"
                        type ="time"
                      ></v-text-field>
                    </v-col>
                  </v-row>
                </v-container>
              </v-card-text>

              <v-card-actions>
              <v-spacer></v-spacer>
                <v-btn
                  color="blue darken-1"
                  text
                  @click="close"
                >
                  Cancel
                </v-btn>

                <v-btn
                  color="blue darken-1"
                  text
                  @click="checkForm()"
                >
                  Save
                </v-btn>
              </v-card-actions>
            </v-card>
          </v-dialog>

          <v-dialog v-model="dialogDelete" max-width="500px">
            <v-card>
              <div class="pop-up">削除してもよろしいですか？</div>
                <v-card-actions>
                <v-spacer></v-spacer>
                  <v-btn color="blue darken-1" text @click="closeDelete">Cancel</v-btn>
                  <v-btn color="blue darken-1" text @click="deleteItemConfirm">OK</v-btn>
                  <v-spacer></v-spacer>
                </v-card-actions>
            </v-card>
          </v-dialog>
      
          <v-data-table
            :headers="headers"
            :items="menus"
            :search="search"
            :items-per-page="10"
            class="elevation-1"
          >
      
          <template v-slot:[`item.working_hours`]="{ item }">
            {{ item.working_hours }}
          </template>

            <template v-slot:[`item.actions`]="{ item }">
              <v-icon
                large
                color="primary"
                class="mr-2"
                @click="editItem(item)"
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
            </template>
          </v-data-table>
        </v-card>
      </v-col>
    </v-row>
  </v-app>
</template>

<script>
import axios from 'axios';
import dayjs from 'dayjs'
import 'dayjs/locale/ja'
dayjs.locale(`ja`)

export default {
  data() {
    return {
      dialog: false,
      dialogDelete: false,
      menus: [],
      errors: [],
      items: ['チワワ', 'ダックス', 'ヨークシャーテリア', 'パピヨン', 'ポメラニアン', 'マルチーズ',
              'トイプードル', 'シー・ズー', 'キャバリア', 'Mシュナウザー', 'パグ', 'ビーグル',
              'フレンチブルドッグ', '柴犬', 'コッカースパニエル', 'ボーダーコリー', 'その他'],
      menu_items: ['シャンプーカット', 'シャンプーセット', '爪切り'],
      headers: [
          {
            text: 'Menu',
            align: 'start',
            sortable: false,
            value: "menu_name",
          },
          { text: '犬種', value: "breed" },
          { text: '値段(円)', value: "price" },
          { text: '所用時間 (分)', value: "working_hours" },
          { text: '　編集 / 削除', value: "actions"}
        ],
        search: '',
        editedIndex: -1,
        editedItem: {
          menu_name: '',
          breed: '',
          price: '',
          working_hours: '',
        },
        defaultItem: {
          menu_name: '',
          breed: '',
          price: '',
          working_hours: '',
      },
    }
  },

  mounted() {
    axios
      .get('/api/v1/menus.json')
      .then(response => (this.menus = response.data))
      .then(function(menus) {
        menus.map(function(menu) {
         menu.working_hours = dayjs(menu.working_hours).format('HH:mm');
        });
      })
  },
  watch: {
      dialog (val) {
        val || this.close()
        this.errors = [];
      },
    },
  computed: {
      formTitle () {
        return this.editedIndex === -1 ? 'New Item' : 'Edit Item'
      },
    },
  methods: {
    close () {
        this.dialog = false
        this.$nextTick(() => {
          this.editedItem = Object.assign({}, this.defaultItem)
          this.editedIndex = -1
        })
      },
       editItem (item) {
        this.editedIndex = this.menus.indexOf(item)
        this.editedItem = Object.assign({}, item)
        console.log(this.editedItem.id)
        this.dialog = true
      },
      deleteItem (item) {
        this.editedIndex = this.menus.indexOf(item)
        this.editedItem = Object.assign({}, item)
        this.dialogDelete = true
      },
      deleteItemConfirm () {
        axios.delete(`/api/v1/menus/${this.editedItem.id}`)
      .then(response => {
        alert("削除しました");
          this.menus.splice(this.editedIndex, 1)
        this.closeDelete()
      })
      },
      closeDelete () {
        this.dialogDelete = false
        this.$nextTick(() => {
          this.editedItem = Object.assign({}, this.defaultItem)
          this.editedIndex = -1
        })
      },
      checkForm() {
        if (this.editedItem.menu_name && this.editedItem.breed && this.editedItem.price && this.editedItem.working_hours) {
          console.log(1)
          this.create_menu()
        }
        this.errors = [];

        if (!this.editedItem.menu_name) {
          this.errors.push('メニューを選択してください');
        }
        if (!this.editedItem.breed) {
          this.errors.push('犬種を選択してください');
        }
        if (!this.editedItem.price) {
          this.errors.push('価格を設定してください');
        }
        if (!this.editedItem.working_hours) {
          this.errors.push('所用時間を選択してください');
        }
      },


      create_menu() {
        if (this.editedIndex > -1) {
        axios.patch(`/api/v1/menus/${this.editedItem.id}`, {
          params: this.editedItem
        })
        .then(response => {
          alert("登録が完了しました");
            Object.assign(this.menus[this.editedIndex], this.editedItem)
          this.close()
        })
        .catch((error) => {
          console.log(error);
          this.close()
        })
        } else {
          axios.post('/api/v1/menus', {
        params: this.editedItem
        })
        .then(response => {
          alert("登録が完了しました");
            //this.menus.push(this.editedItem)
            this.$router.go({path: '/employees/settings', force: true});
          this.close()
        })
        .catch((error) => {
          console.log(error);
          this.close()
        })
        }
      },
    },
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
.pop-up {
  font-size: 1em;
  text-align: center;
  padding: 10px;
}
.error_text {
  color: red;
}
</style>