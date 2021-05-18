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
          max-width="500px"
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
            
            <v-card-text>
              <v-container>
                <v-row>
                  <v-col
                    cols="12"
                    sm="6"
                    md="5"
                  >
                    <v-text-field
                      v-model="editedItem.menu_name"
                      label="メニュー名"
                    ></v-text-field>
                  </v-col>
                  <v-col
                    cols="12"
                    sm="6"
                    md="5"
                  >
                    <v-text-field
                      v-model="editedItem.breed"
                      label="犬種"
                    ></v-text-field>
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
                @click="create_menu()"
              >
                Save
              </v-btn>
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
          {{ item.working_hours | moment }}
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
import moment from 'moment';

export default {
  data() {
    return {
      dialog: false,
      menus: [],
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
  },
  filters: {
    moment: function (data) {
       return moment(data).format('HH:mm')
    }
  },
  watch: {
      dialog (val) {
        val || this.close()
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
    create_menu() {
      axios.post('/api/v1/menus', {
      params: this.editedItem
      })
      .then(response => {
        alert("登録が完了しました");
         if (this.editedIndex > -1) {
          Object.assign(this.menus[this.editedIndex], this.editedItem)
        } else {
          this.menus.push(this.editedItem)
        }
        this.close()
      })
      .catch((error) => {
        console.log(error);
      })
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

.pets_index {
  margin-top: 50px;
}

.pets_index th {
  background-color: #f5f5f5;
  vertical-align: middle;
  text-align: center;
}

.pets_index td {
  vertical-align: middle;
  text-align: center;
}
</style>