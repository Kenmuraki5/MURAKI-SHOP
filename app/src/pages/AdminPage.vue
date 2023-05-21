<template>
  <div>
    <div class="flex flex-wrap sm:items-center sm:justify-between p-4 bg-black">
      <RouterLink class="flex flex-shrink-0 items-center" to="/">
        <span class="block h-auto w-auto font-black text-white lg:block" alt="Your Company">MURAKI COMIC</span>
      </RouterLink>
      <div class="flex mt-4 sm:mt-0 sm:ml-auto">
        <button class="ml-5 text-white font-bold py-2 px-4 rounded hover:bg-gray-700"
          @click="toggleComponent('add')">Add</button>
        <button class="ml-5 text-white font-bold py-2 px-4 rounded hover:bg-gray-700"
          @click="toggleComponent('table')">Edit</button>
        <button class="ml-5 text-white font-bold py-2 px-4 rounded hover:bg-gray-700"
          @click="toggleComponent('slip')">Slip</button>
      </div>
    </div>

    <AddBook v-if="showAddBook" @book="addForm" :key="re"/>
    <div v-if="showBookTable">
      <BookTable @button-clicked="bookFromEdit" :key="re" @book="save" />
      <EditForm v-if="bookEditing" :book="bookEditing" :key="bookEditing.isbn" @book="save" />
    </div>
    <SlipTable v-if="showSlipTable" @slip="slipUpdate" :key="reSlip" />
  </div>
</template>
<!-- <template>
  <div>

    <AddBook />
    <div>
      <BookTable @button-clicked="bookFromEdit" :key="re" @book="save" />
      <EditForm v-if="bookEditing" :book="bookEditing" :key="bookEditing.isbn" @book="save" />
    </div>
    <SlipTable @slip="slipUpdate" :key="reSlip" />
  </div>
</template> -->
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
      showAddBook: true,
      showBookTable: false,
      showSlipTable: false,
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
    addForm(){
      this.re++
    },
    toggleComponent(component) {
      if (component === 'add') {
        this.showAddBook = !this.showAddBook;
        this.showBookTable = false
        this.showSlipTable = false
      } else if (component === 'table') {
        this.showAddBook = false
        this.showBookTable = !this.showBookTable;
        this.showSlipTable = false
      } else if (component === 'slip') {
        this.showAddBook = false
        this.showBookTable = false
        this.showSlipTable = !this.showSlipTable;
      }
      // Additional toggling logic...
    },
    bookFromEdit(book) {
      this.bookEditing = book
      console.log(this.bookEditing)
    },

    
  },
  created() {
    axios.get(`http://localhost:3000/user/me`)
      .then((res) => {
        if (res.data.type != "admin") {
          this.$router.push("/")
        }
      })
      .catch((err) => {
        console.log(err.response.data)
      })
  }
}
</script>
