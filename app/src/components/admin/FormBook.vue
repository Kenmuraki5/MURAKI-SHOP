<template>
    <section class="min-h-screen flex flex-col ">
        <div class="flex flex-1 items-center justify-center ">
            <div class="rounded-lg sm:border-2 px-4 lg:px-24 py-16 lg:max-w-xl sm:max-w-md w-full text-center bg-white">
                <form @submit.prevent="submit">
                    <h1 class="font-bold tracking-wider text-3xl mb-8 w-full text-gray-600">
                        {{ name }}
                    </h1>
                    <div class="py-2 text-left">
                        <input type="text"
                            class="bg-gray-200 border-2 border-gray-100 focus:outline-none bg-gray-100 block w-full py-2 px-4 rounded-lg focus:border-gray-700"
                            placeholder="ISBN" v-model="isbn" />
                    </div>
                    <div class="py-2 text-left">
                        <input type="text"
                            class="bg-gray-200 border-2 border-gray-100 focus:outline-none bg-gray-100 block w-full py-2 px-4 rounded-lg focus:border-gray-700"
                            placeholder="Title" v-model="title" />
                    </div>
                    <div class="py-2 text-left">
                        <input type="number"
                            class="bg-gray-200 border-2 border-gray-100 focus:outline-none bg-gray-100 block w-full py-2 px-4 rounded-lg focus:border-gray-700"
                            placeholder="Price" v-model="price" />
                    </div>
                    <div class="py-2 text-left"></div>
                    <div class="py-2 text-left">
                        <textarea placeholder="Description" v-model="description"
                            class="block w-full px-4 py-2 leading-tight text-gray-700 bg-gray-200 border border-gray-300 rounded-md focus:outline-none"
                            rows="5"></textarea>
                    </div>
                    <br>
                    <div>
                        <select id="category-select" name="category"
                            class="block px-6 w-full rounded-md border-0 py-2 text-gray-900 bg-gray-200 shadow-sm ring-1 ring-inset ring-gray-300 "
                            v-model="category">
                            <option value="">-- Select Category --</option>
                            <option value="manga">Manga</option>
                            <option value="novel">Novel</option>
                        </select>
                    </div>
                    <br>
                    <div>
                        <select id="publisher-select" name="publisher"
                            class="block px-6 w-full rounded-md border-0 py-2 text-gray-900 bg-gray-200 shadow-sm ring-1 ring-inset ring-gray-300 "
                            v-model="publisher">
                            <option value=0>-- Select Publisher --</option>
                            <option v-for="pu in publisherList" :key="pu.publisher_id" :value="pu.publisher_id">{{
                                pu.publisher_name }}</option>
                            <option value=-1>Add New</option>
                        </select>
                        <br>
                        <input v-if="publisher == -1" type="text"
                            class="bg-gray-200 border-2 border-gray-100 focus:outline-none bg-gray-100 block w-full py-2 px-4 rounded-lg focus:border-gray-700"
                            placeholder="New Publisher" v-model="newPublisher" />
                    </div>
                    <div class="py-2 text-left">
                        <label for="date">Publisher date</label>
                        <input name="date" type="date"
                            class="bg-gray-200 border-2 border-gray-100 focus:outline-none bg-gray-100 block w-full py-2 px-4 rounded-lg focus:border-gray-700"
                            placeholder="publisher_date" v-model="publisherDate" />
                    </div>
                    <br>
                    <div>
                        <select id="author-select" name="author"
                            class="block px-6  w-full rounded-md border-0 py-2 text-gray-900 bg-gray-200 shadow-sm ring-1 ring-inset ring-gray-300 "
                            v-model="author">
                            <option value=0>-- Select Author --</option>
                            <option v-for="au in authorList" :key="au.author_id" :value="au.author_id">{{ au.author_name }}
                            </option>
                            <option value=-1>Add New</option>
                        </select>
                        <br>
                        <input v-if="author == -1" type="text"
                            class="bg-gray-200 border-2 border-gray-100 focus:outline-none bg-gray-100 block w-full py-2 px-4 rounded-lg focus:border-gray-700"
                            placeholder="New Author" v-model="newAuthor" />
                        <input v-if="author == -1" type="text"
                            class="bg-gray-200 border-2 border-gray-100 focus:outline-none bg-gray-100 block w-full py-2 px-4 rounded-lg focus:border-gray-700"
                            placeholder="New Author alias" v-model="newAuthorAlias" />
                    </div>
                    <div class="py-2 text-left">Genres :</div>
                    <div class="grid grid-cols-3 gap-4">
                        <label class="" v-for="(genre, index) in genres" :key="index">
                            <input type="checkbox" class="w-4 h-4 rounded" v-model="selectedGenres" :value="genre.genre_id">
                            {{ genre.genre }}
                        </label>
                        
                    </div>
                    <br>
                    <label for="upload-button"
                        class="flex items-center justify-center px-4 py-2 text-gray-100 bg-blue-600 rounded-md cursor-pointer">
                        <span class="mr-2">Upload Image {{ imageName }}</span>
                        <input id="upload-button" type="file" class="hidden" ref="file" @change="handleFileUpload()" />
                    </label>
                    <div class="py-2 text-left">
                        <input type="number"
                            class="bg-gray-200 border-2 border-gray-100 focus:outline-none bg-gray-100 block w-full py-2 px-4 rounded-lg focus:border-gray-700"
                            placeholder="Amount" v-model="inStock" />
                    </div>
                    <div class="py-2">
                        <button type="submit" @click="validateForm()"
                            class="border-2 border-gray-100 focus:outline-none bg-purple-600 text-white font-bold tracking-wider block w-full p-2 rounded-lg focus:border-gray-700 hover:bg-purple-700">
                            Submit
                        </button>
                    </div>
                    
                </form>
            </div>
        </div>
    </section>
</template>

<script>
import axios from '@/plugins/axios'

export default {
    props: {
        fname: String,
        fisbn: String,
        ftitle: String,
        fprice: Number,
        fdescription: String,
        fcategory: String,
        fpublisherDate: String,
        fpublisher: Number,
        fauthor: Number,
        fselectedGenres: Array,
        fimage: String,
        fimageName: String,
        finStock: Number,
    },
    data() {
        return {
            file:null,
            name: this.fname,
            isbn: this.fisbn,
            title: this.ftitle,
            price: this.fprice,
            description: this.fdescription,
            category: this.fcategory,
            publisherDate: this.fpublisherDate,
            publisher: this.fpublisher,
            author: this.fauthor,
            selectedGenres: this.fselectedGenres,
            image: this.fimage,
            imageName: this.fimageName,
            inStock: this.finStock,
            publisherList: null,
            authorList: null,
            genres: null,
            newPublisher: null,
            newAuthor: null,
            newAuthorAlias: null,
            modal:false
        }
    },
    methods: {
        handleFileUpload() {
            this.file = this.$refs.file.files[0];
            this.imageName = this.file.name
        },
        showImage() {
            console.log(this.image)
        },
        submitForm() {
            // emit a submit-form event with the form data
            this.$emit('submit-form', {
                isbn: this.isbn,
                title: this.title,
                price: this.price,
                description: this.description,
                category: this.category,
                publisherDate: this.publisherDate.slice(0, 10),
                publisher: this.publisher,
                author: this.author,
                newPublisher: this.newPublisher,
                newAuthor: this.newAuthor,
                newAuthorAlias: this.newAuthorAlias,
                selectedGenres: this.selectedGenres,
                image: this.image,
                file: this.file,
                inStock: this.inStock,
            });
            this.isbn = null
            this.title = null
            this.price = null
            this.description = null
            this.category = ""
            this.publisherDate = null
            this.publisher = 0
            this.author = 0
            this.selectedGenres = null
            this.image = null
            this.imageName = null
            this.inStock = null
        },
        validateForm() {
            let errors = []
            if (!this.isbn || this.isbn.length != 13) {
                errors.push('ISBN is something wrong.')
            }
            if (!this.title) {
                errors.push('Title is something wrong.')
            }
            if (this.price < 0) {
                errors.push('Price is something wrong.')
            }
            if (!this.description) {
                errors.push('Description is something wrong.')
            }
            if (!this.category) {
                errors.push('Category is something wrong.')
            }
            if (!this.publisher && this.publisher !== -1 || (this.publisher == -1 && !this.newPublisher)) {
                errors.push('Publisher is something wrong.')
            }
            if (!this.publisherDate) {
                errors.push('Publisher date is something wrong.')
            }
            if (!this.author && this.author !== -1 || (this.author == -1 && !this.newAuthor)) {
                errors.push('Author is something wrong.')
            }
            if (this.author == '-1' && !this.newAuthorAlias) {
                errors.push('Author alias is something wrong.')
            }
            if (!this.selectedGenres.length) {
                errors.push('At least one genre must be selected.')
            }
            if (!this.file && !this.image) {
                errors.push('Please upload file.')
            }
            if (this.inStock < 0 || !this.inStock) {
                errors.push('Amount is something wrong.')
            }
            if (errors.length) {
                // Display error messages to user or handle them however you wish
                alert(errors)
                return false
            }
            // If all fields are valid, submit form
            this.submitForm()
        }
    },
    created() {
        axios.get("http://localhost:3000/formBook")
            .then(res => {
                this.publisherList = res.data[0]
                this.authorList = res.data[1]
                this.genres = res.data[2]
            }
            ).
            catch(
                err => console.log(err)
            )
    },
}
</script>

<style></style>