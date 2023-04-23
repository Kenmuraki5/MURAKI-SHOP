<template>
    <!-- EDIT BOOK -->
    <div class="overflow-x-auto rounded-lg border border-gray-200 shadow-md m-5">
        <table class="table-auto w-full border-collapse bg-white text-left text-sm text-gray-500">
            <thead class="bg-gray-50">
                <tr>
                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                        ISBN</th>
                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                        Title</th>
                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                        Description</th>
                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                        Price</th>
                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                        Category</th>
                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                        Publisher Name</th>
                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                        Author Name</th>
                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                        Publisher Date</th>
                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                        Image</th>
                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                        In Stock</th>
                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                        Genres</th>
                    <th scope="col" class="px-6 py-3 font-medium text-gray-900"></th>

                </tr>
            </thead>
            <tbody class="bg-white divide-y divide-gray-200">
                <tr class="hover:bg-gray-50" v-for="book in allBook" :key="book.isbn">
                    <td class="px-6 py-4 ">
                        {{ book.isbn }}
                    </td>
                    <td class="px-6 py-4 ">
                        {{ book.book_name }}
                    </td>
                    <td class="px-6 py-4 ">
                        {{ book.book_description }}
                    </td>
                    <td class="px-6 py-4 ">
                        {{ book.book_price }}
                    </td>
                    <td class="px-6 py-4 ">
                        {{ book.book_category }}
                    </td>
                    <td class="px-6 py-4 ">
                        {{ book.publisher_name }}
                    </td>
                    <td class="px-6 py-4 ">
                        {{ book.author_name }}
                    </td>
                    <td class="px-6 py-4 ">
                        {{ book.publisher_date.slice(0, 10) }}
                    </td>
                    <td class="px-6 py-4 ">
                        <img class="w-20 h-30" :src="`http://localhost:3000/uploads/${book.book_img}`" alt="">
                        {{ book.book_img }}
                    </td>
                    <td class="px-6 py-4 ">
                        {{ book.in_stock }}
                    </td>
                    <td class="px-6 py-4 break-all">
                        {{ book.genres }}
                    </td>
                    <td class="px-6 py-4 ">
                        <button @click="edit(book)">Edit</button>
                        <button @click="delBook(book)">Delete</button>
                    </td>
                </tr>
            </tbody>
        </table>

    </div>
</template>

<script>
import axios from 'axios';
export default {
    data() {
        return {
            allBook: null,
        }
    },
    methods: {
        edit(book) {
            this.$emit('button-clicked', book)
        },
        delBook(book) {
            axios.delete("http://localhost:3000/editBook/", { params: { isbn: book.isbn } }, {
                headers: {
                    'Content-Type': 'application/json'
                }
            })
                .then(res => {
                    console.log(res)
                    this.$emit('book', null);
                }
                ).
                catch(err => console.log(err)
                )

        }
    },
    created() {
        console.log("create")
        axios.get("http://localhost:3000/editBook")
            .then(res => {
                this.allBook = res.data
                console.log(this.allBook)
            }
            ).
            catch(
                err => console.log(err)
            )
    },
};
</script>