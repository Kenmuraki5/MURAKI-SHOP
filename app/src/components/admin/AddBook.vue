<template>
    <!-- ADD BOOK -->

    <FormBook name="Add Book" @submit-form="submit" fname="Add Book" fcategory=""
    :fpublisher=publisher :fauthor=author :fselectedGenres=[] />
</template>

<script>
import axios from '@/plugins/axios'
import FormBook from './FormBook.vue';
export default {
    components: {
        FormBook,
    },
    data() {
        return {
            publisher:0,
            author:0
        }
    },
    methods: {
        submit(book) {
            console.log(book)
            var formData = new FormData()
            formData.append("isbn", book.isbn)
            formData.append("title", book.title)
            formData.append("price", book.price)
            formData.append("description", book.description)
            formData.append("category", book.category)
            formData.append("publisherDate", book.publisherDate)
            if (book.publisher == -1) {
                formData.append("publisher", book.newPublisher)
            } else {
                formData.append("publisher", book.publisher)
            }
            if (book.author == -1) {
                formData.append("author", book.newAuthor)
                formData.append("newAuthorAlias", book.newAuthorAlias)
            } else {
                formData.append("author", book.author)
            }
            formData.append("genres", book.selectedGenres)
            formData.append("image", book.file)
            formData.append("inStock", book.inStock)

            axios.post('http://localhost:3000/addBook', formData, {
                headers: {
                    'Content-Type': 'multipart/form-data'
                }
            }).then((res) => {
                console.log(res.data)
                alert("Add Book success")
                this.$emit('book');
            }).catch(err => {
                console.log(err)
                alert("Add Book Failed")
            })
        },
    }
};
</script>