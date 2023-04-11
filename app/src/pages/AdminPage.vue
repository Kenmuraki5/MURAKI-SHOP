<template>
    <!-- ADD BOOK -->
    <section class="min-h-screen flex flex-col">
        <div class="flex flex-1 items-center justify-center">
            <div class="rounded-lg sm:border-2 px-4 lg:px-24 py-16 lg:max-w-xl sm:max-w-md w-full text-center">
                <section>
                    <h1 class="font-bold tracking-wider text-3xl mb-8 w-full text-gray-600">
                        Add Book
                    </h1>
                    <div class="py-2 text-left">
                        <input type="text"
                            class="bg-gray-200 border-2 border-gray-100 focus:outline-none bg-gray-100 block w-full py-2 px-4 rounded-lg focus:border-gray-700"
                            placeholder="ISBN" v-model="isbn"/>
                    </div>
                    <div class="py-2 text-left">
                        <input type="text"
                            class="bg-gray-200 border-2 border-gray-100 focus:outline-none bg-gray-100 block w-full py-2 px-4 rounded-lg focus:border-gray-700"
                            placeholder="Title" v-model="title"/>
                    </div>
                    <div class="py-2 text-left">
                        <input type="number"
                            class="bg-gray-200 border-2 border-gray-100 focus:outline-none bg-gray-100 block w-full py-2 px-4 rounded-lg focus:border-gray-700"
                            placeholder="Price" v-model="price"/>
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
                            class="block w-full rounded-md border-0 py-1.5 text-gray-900 bg-gray-200 shadow-sm ring-1 ring-inset ring-gray-300 "
                            v-model="category">
                            <option value="">-- Select Category --</option>
                            <option value="manga">Manga</option>
                            <option value="novel">Novel</option>
                        </select>
                    </div>
                    <br>
                    <div>
                        <select id="publisher-select" name="publisher"
                            class="block w-full rounded-md border-0 py-1.5 text-gray-900 bg-gray-200 shadow-sm ring-1 ring-inset ring-gray-300 "
                            v-model="publisher">
                            <option value="">-- Select Publisher --</option>
                            <option v-for="pu in publisherList" :key="pu.publisher_id" :value="pu.publisher_id">{{
                                pu.publisher_name }}</option>
                            <option value="x">Add New</option>
                        </select>
                        <br>
                        <input v-if="publisher == 'x'" type="text"
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
                            class="block  w-full rounded-md border-0 py-1.5 text-gray-900 bg-gray-200 shadow-sm ring-1 ring-inset ring-gray-300 "
                            v-model="author">
                            <option value="">-- Select Author --</option>
                            <option v-for="au in authorList" :key="au.author_id" :value="au.author_id">{{ au.author_name }}
                            </option>
                            <option value="x">Add New</option>
                        </select>
                        <br>
                        <input v-if="author == 'x'" type="text"
                            class="bg-gray-200 border-2 border-gray-100 focus:outline-none bg-gray-100 block w-full py-2 px-4 rounded-lg focus:border-gray-700"
                            placeholder="New Author" v-model="newAuthor" />
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
                        <input id="upload-button" type="file" class="hidden" ref="file" @change="handleFileUpload()"/>
                    </label>
                    <div class="py-2 text-left">
                        <input type="number"
                            class="bg-gray-200 border-2 border-gray-100 focus:outline-none bg-gray-100 block w-full py-2 px-4 rounded-lg focus:border-gray-700"
                            placeholder="Amount" v-model="inStock"/>
                    </div>
                    <div class="py-2">
                        <button type="submit" @click="validateForm()"
                            class="border-2 border-gray-100 focus:outline-none bg-purple-600 text-white font-bold tracking-wider block w-full p-2 rounded-lg focus:border-gray-700 hover:bg-purple-700">
                            Submit
                        </button>
                    </div>
                </section>
            </div>
        </div>
    </section>
</template>

<script>
import axios from 'axios';
export default {
    data() {
        return {
            isbn: "1234567890123",
            title: "test title",
            price: 100,
            description: "test description",
            category: "manga",
            publisherDate: null,
            publisherList: null,
            authorList: null,
            publisher: "",
            author: "",
            newPublisher: null,
            newAuthor: null,
            genres: null,
            selectedGenres: [],
            image:null,
            imageName:null,
            inStock:null
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
    methods: {
        handleFileUpload(){
          this.image = this.$refs.file.files[0];
          this.imageName = this.image.name
      },
        submit() {
            var formData = new FormData()
            formData.append("isbn", this.isbn)
            formData.append("title", this.title)
            formData.append("price", this.price)
            formData.append("description", this.description)
            formData.append("category", this.category)
            formData.append("publisherDate", this.publisherDate)
            if (this.publisher == "x") {
                formData.append("publisher", this.newPublisher)
                formData.append("newPublisher", 1)
            } else {
                formData.append("publisher", this.publisher)
                formData.append("newPublisher", 0)
            }
            if (this.author == "x") {
                formData.append("author", this.newAuthor)
                formData.append("newAuthor", 1)
            } else {
                formData.append("author", this.author)
                formData.append("newAuthor", 0)
            }
            formData.append("genres", this.selectedGenres)
            formData.append("image", this.image)
            formData.append("inStock", this.inStock)

            axios.post('http://localhost:3000/addBook', formData,{
              headers: {
              'Content-Type': 'multipart/form-data'
              }
          }).then(res => console.log(res.data)).catch(err => console.log(err))
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
            if (!this.publisher && this.publisher !== 'x' || (this.publisher == 'x' && !this.newPublisher)) {
                errors.push('Publisher is something wrong.')
            }
            if (!this.publisherDate) {
                errors.push('Publisher date is something wrong.')
            }
            if (!this.author && this.author !== 'x' || (this.author == 'x' && !this.newAuthor)) {
                errors.push('Author is something wrong.')
            }
            if (!this.selectedGenres.length) {
                errors.push('At least one genre must be selected.')
            }
            if (!this.image) {
                errors.push('Please upload file.')
            }
            if (errors.length) {
                // Display error messages to user or handle them however you wish
                console.log(errors)
                return false
            }
            if (this.inStock < 0) {
                errors.push('Amount is something wrong.')
            }
            // If all fields are valid, submit form
            this.submit()
        }

    }
};
</script>