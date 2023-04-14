<template>
    <FormBook name="Edit Book" @submit-form="submit" fname="Edit Book" :fisbn=this.book.isbn :ftitle="this.book.book_name"
        :fprice="this.book.book_price" :fdescription="this.book.book_description" :fcategory="this.book.book_category"
        :fpublisherDate="this.book.publisher_date.slice(0, 10)" :fpublisher="this.book.publisher_id"
        :fauthor="this.book.author_id" :fselectedGenres="this.book.genres_id.split(',')" :fimage="image"
        :fimageName="this.book.book_img" :finStock="this.book.in_stock" />
</template>

<script>
import axios from 'axios';
import FormBook from './FormBook.vue';

export default {
    components: {
        FormBook,
    },
    props: {
        book: Object
    },
    data() {
        return {
            image: new File([], "sameasbefore.png")
        }
    },
    methods: {
        submit(book) {
            var formData = new FormData()
            formData.append("oldIsbn", this.book.isbn)
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

            axios.put('http://localhost:3000/editBook', formData, {
                headers: {
                    'Content-Type': 'multipart/form-data'
                }
            }).then(res => {
                console.log(res.data)
                this.$emit('book', null);
            })
                .catch(err => console.log(err))
        },
    },
}
</script>

<style></style>