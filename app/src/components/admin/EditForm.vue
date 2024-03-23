<template>

    <FormBook name="Edit Book" @submit-form="submit" fname="Edit Book" :fisbn=this.book.isbn :ftitle="this.book.book_name"
        :fprice="this.book.book_price" :fdescription="this.book.book_description" :fcategory="this.book.book_category"
        :fpublisherDate="this.book.publisher_date.slice(0, 10)" :fpublisher="this.book.publisher_id"
        :fauthor="this.book.author_id" :fselectedGenres="this.book.genres_id.split(',')" :fimage="this.book.book_img"
        :fimageName="this.book.book_img" :finStock="this.book.in_stock" />
    
</template>

<script>
import axios from '@/plugins/axios'
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
            // image: new File([], "sameasbefore.png")
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
            if(book.file){
                formData.append("image", book.file)
            }else{
                formData.append("sameImage", book.image)
            }
            formData.append("inStock", book.inStock)
            console.log(formData)
            axios.put('http://34.16.145.46/api/editBook', formData, {
                headers: {
                    'Content-Type': 'multipart/form-data'
                }
            }).then(res => {
                console.log(res.data)
                this.$emit('book', null);
            })
            .catch(err => {
                console.log(err)
                alert("Edit Book Failed")
            })
        },
    },
}
</script>

<style></style>