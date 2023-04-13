<template>
    <!-- ADD BOOK -->

    <FormBook name="Add Book" @submit-form="submit" fname="Add Book" fcategory=""
    :fpublisher=publisher :fauthor=author :fselectedGenres=[] />
</template>

<script>
import axios from 'axios';
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
                formData.append("newPublisher", 1)
            } else {
                formData.append("publisher", book.publisher)
                formData.append("newPublisher", 0)
            }
            if (book.author == -1) {
                formData.append("author", book.newAuthor)
                formData.append("newAuthorAlias", book.newAuthorAlias)
                formData.append("newAuthor", 1)
            } else {
                formData.append("author", book.author)
                formData.append("newAuthor", 0)
            }
            formData.append("genres", book.selectedGenres)
            formData.append("image", book.image)
            formData.append("inStock", book.inStock)

            axios.post('http://localhost:3000/addBook', formData, {
                headers: {
                    'Content-Type': 'multipart/form-data'
                }
            }).then((res) => {
                console.log(res.data)
                alert("Add Book success")
            }).catch(err => console.log(err))
        },
    }
};
</script>