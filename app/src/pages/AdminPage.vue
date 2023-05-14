<template>
  <div>
    <div>
      <button @click="toggleComponent">{{ selectedOption === 'edit' ? 'Switch to Edit' : 'Switch to Add' }}</button>
    </div>
    <div v-if="selectedOption === 'add'">
      <AddBook />
    </div>
    <div v-else>
      <BookTable @button-clicked="bookFromEdit" :key="re" @book="save" />
      <EditForm v-if="bookEditing" :book="bookEditing" :key="bookEditing.isbn" @book="save" />
    </div>
    <SlipTable @slip="slipUpdate" :key="reSlip" />
  </div>
</template>
<script>
import axios from '@/plugins/axios'
import AddBook from '../components/admin/AddBook.vue'
import BookTable from '../components/admin/BookTable.vue'
import EditForm from '../components/admin/EditForm.vue'
import SlipTable from '../components/admin/SlipTable.vue'

export default {
  name: 'AdminPage',
  components: {
    AddBook,
    BookTable,
    EditForm,
    SlipTable
  },
  data() {
    return {
      selectedOption: 'add',
      bookEditing: null,
      re: 0,
      reSlip: 0
    }
  },
  methods: {
    save(x) {
      this.bookEditing = x
      this.re++
    },
    slipUpdate(x) {
      console.log(x)
      this.reSlip++
    },

    toggleComponent() {
      this.selectedOption = this.selectedOption === 'add' ? 'edit' : 'add'
    },
    bookFromEdit(book) {
      this.bookEditing = book
      console.log(this.bookEditing)
    }
  },
    created() {
      axios.get(`http://localhost:3000/user/me`)
            .then((res) => {
               if(res.data.type != "admin"){
                this.$router.push("/")
               }
            })
            .catch((err) => { 
                console.log(err.response.data)
            })
    }
}
</script>
