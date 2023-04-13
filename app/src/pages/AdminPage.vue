<template>
    <div>
      <div>
        <button @click="toggleComponent">{{selectedOption === 'edit' ? 'Switch to Edit' : 'Switch to Add'}}</button>
      </div>
      <div v-if="selectedOption === 'add'">
        <AddBook/>
      </div>
      <div v-else>
        <BookTable @button-clicked="bookFromEdit"/>
        <EditForm v-if="bookEditing" :book="bookEditing" :key="bookEditing.isbn"/>
      </div>
    </div>

  </template>
  <script>
  import AddBook from '../components/AddBook.vue'
  import BookTable from '../components/BookTable.vue'
  import EditForm from '../components/EditForm.vue'

  export default {
    name: 'AdminPage',
    components: {
        AddBook,
        BookTable,
        EditForm
    },
    data() {
      return {
        selectedOption: 'add',
        bookEditing:null
      }
    },
    methods: {
    toggleComponent() {
      this.selectedOption = this.selectedOption === 'add' ? 'edit' : 'add'
    },
    bookFromEdit(book){
      this.bookEditing = book
      console.log(this.bookEditing)
    }
  }
}
</script>
