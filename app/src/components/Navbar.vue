<template>
  <Disclosure as="nav" class="bg-neutral-900" v-slot="{ open }">
    <div class="mx-auto max-w-7xl px-2 sm:px-6 lg:px-8">
      <div class="relative flex h-16 items-center justify-between">
        <div class="absolute inset-y-0 left-0 flex items-center sm:hidden">
          <!-- Mobile menu button-->
          <DisclosureButton
            class="inline-flex items-center justify-center rounded-md p-2 text-gray-400 hover:bg-gray-700 hover:text-white focus:outline-none focus:ring-2 focus:ring-inset focus:ring-white">
            <span class="sr-only">Open main menu</span>
            <Bars3Icon v-if="!open" class="block h-6 w-6" aria-hidden="true" />
            <XMarkIcon v-else class="block h-6 w-6" aria-hidden="true" />
          </DisclosureButton>
        </div>
        <div class="flex flex-1 items-center justify-center sm:items-stretch sm:justify-start">
          <RouterLink class="flex flex-shrink-0 items-center" to="/">
            <span class="block h-auto w-auto font-black text-white lg:block" alt="Your Company">MURAKI COMIC</span>
          </RouterLink>
          <div class="hidden sm:ml-6 sm:block">
            <div class="flex space-x-4">
              <RouterLink v-for="item in navigation" :key="item.name" :to="item.href" :class="[
                item.current
                  ? 'bg-gray-900 text-white'
                  : 'text-gray-300 hover:bg-gray-700 hover:text-white',
                'px-3 py-2 rounded-md text-sm font-medium',
              ]" :aria-current="item.current ? 'page' : undefined">{{ item.name }}</RouterLink>
            </div>
          </div>
        </div>
        <div class="absolute inset-y-0 right-0 flex items-center pr-2 sm:static sm:inset-auto sm:ml-6 sm:pr-0">
          <button @click="isOpen = true" data-modal-target="top-right-modal" data-modal-toggle="top-right-modal"
            class="rounded-full bg-gray-800 p-1 text-gray-400 hover:text-white focus:outline-none focus:ring-2 focus:ring-white focus:ring-offset-2 focus:ring-offset-gray-800"
            type="button">
            <span class="sr-only">View notifications</span>
            <ShoppingCartIcon class="h-6 w-6" aria-hidden="true" />
            {{ totalCart }}
          </button>

          <TransitionRoot as="template" :show="isOpen">
            <Dialog as="div" class="relative z-50" @close="isOpen = false">
              <TransitionChild as="template" enter="ease-in-out duration-500" enter-from="opacity-0"
                enter-to="opacity-100" leave="ease-in-out duration-500" leave-from="opacity-100" leave-to="opacity-0">
                <div class="fixed inset-0 bg-gray-500 bg-opacity-75 transition-opacity" />
              </TransitionChild>

              <div class="fixed inset-0 overflow-hidden">
                <div class="absolute inset-0 overflow-hidden">
                  <div class="pointer-events-none fixed inset-y-0 right-0 flex max-w-full pl-10">
                    <TransitionChild as="template" enter="transform transition ease-in-out duration-500 sm:duration-700"
                      enter-from="translate-x-full" enter-to="translate-x-0"
                      leave="transform transition ease-in-out duration-500 sm:duration-700" leave-from="translate-x-0"
                      leave-to="translate-x-full">
                      <DialogPanel class="pointer-events-auto relative w-screen max-w-md">
                        <TransitionChild as="template" enter="ease-in-out duration-500" enter-from="opacity-0"
                          enter-to="opacity-100" leave="ease-in-out duration-500" leave-from="opacity-100"
                          leave-to="opacity-0">
                          <div class="absolute top-0 left-0 -ml-8 flex pt-4 pr-2 sm:-ml-10 sm:pr-4">
                            <button type="button"
                              class="rounded-md text-gray-300 hover:text-white focus:outline-none focus:ring-2 focus:ring-white"
                              @click="isOpen = false">
                              <span class="sr-only">Close panel</span>
                              <XMarkIcon class="h-6 w-6" aria-hidden="true" />
                            </button>
                          </div>
                        </TransitionChild>
                        <div class="flex h-full flex-col overflow-y-scroll bg-white py-4 shadow-xl">
                          <div class="px-4 sm:px-6">
                            <DialogTitle class="text-xl font-semibold leading-6 text-gray-900">Shopping Cart
                              ({{ totalCart }})
                            </DialogTitle>
                          </div>
                          <div class="relative mt-2 flex-initial px-4 sm:px-6" v-for="item in cart" :key="item.isbn">
                            <!-- Your content -->
                            <div class="py-6 ">
                              <div class="flex  max-w-md bg-white shadow-lg rounded-lg overflow-hidden">
                                <div class="w-1/3 grid items-center">
                                  <img class="" :src="`http://localhost:3000/uploads/${item.book_img}`" alt="">
                                </div>
                                <div class="w-2/3 p-4">
                                  <h1 class="text-gray-900 font-bold text-2xl">
                                    {{ item.book_name }}
                                  </h1>
                                  <p class="mt-2 text-gray-600 text-sm">
                                    {{ item.book_description }}
                                  </p>
                                  <div class="flex justify-between mt-3">

                                    <button @click="remove(item)"
                                      class="px-3 py-2 bg-gray-800 text-white text-xs font-bold uppercase rounded">
                                      -
                                    </button>
                                    <h1 class="text-gray-700 font-bold text-xl text-center">
                                      {{ item.book_price }} ฿ x{{ item.quantity }}
                                    </h1>
                                    <button @click="add(item)"
                                      class="px-3 py-2 bg-gray-800 text-white text-xs font-bold uppercase rounded">
                                      +
                                    </button>
                                  </div>
                                </div>
                              </div>
                            </div>
                          </div>
                          <router-link
                            class="px-3 absolute inset-x-0 bottom-0 py-2 bg-gray-800 text-white text-xs font-bold uppercase "
                            to="/CheckOut">
                            Checkout {{ totalPrice }}
                          </router-link>
                        </div>
                      </DialogPanel>
                    </TransitionChild>
                  </div>
                </div>
              </div>
            </Dialog>
          </TransitionRoot>
          <!-- Profile dropdown -->
          <Menu as="div" class="relative ml-3">
            <div>
              <MenuButton
                class="flex rounded-full  text-sm focus:outline-none focus:ring-2 focus:ring-white focus:ring-offset-2 focus:ring-offset-gray-800">
                <RouterLink to="/LoginPage" v-if="$store.state.token == ''" class="text-gray-200 hover:text-gray-200">Log in</RouterLink>
                <img v-else class="h-8 w-8 rounded-full"
                  :src="$store.state.image ? `http://localhost:3000/uploads/${$store.state.image}` : 'https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png'"
                  alt="Profile Image"/>
              </MenuButton>
            </div>
            <transition enter-active-class="transition ease-out duration-100"
              enter-from-class="transform opacity-0 scale-95" enter-to-class="transform opacity-100 scale-100"
              leave-active-class="transition ease-in duration-75" leave-from-class="transform opacity-100 scale-100"
              leave-to-class="transform opacity-0 scale-95">
              <MenuItems
                class="absolute right-0 z-10 mt-2 w-48 origin-top-right rounded-md bg-white py-1 shadow-lg ring-1 ring-black ring-opacity-5 focus:outline-none"
                v-if="$store.state.token != ''">
                <MenuItem v-slot="{ active }">
                <RouterLink to="/ProfilePage" :class="[
                  active ? 'bg-gray-100' : '',
                  'block px-4 py-2 text-sm text-gray-700',
                ]">Your Profile</RouterLink>
                </MenuItem>
                <MenuItem v-slot="{ active }">
                <a @click="logout()" :class="[
                  active ? 'bg-gray-100' : '',
                  'block px-4 py-2 text-sm text-gray-700',
                ]">Sign Out</a>
                </MenuItem>
              </MenuItems>
            </transition>
          </Menu>
        </div>
      </div>
    </div>

    <DisclosurePanel class="sm:hidden">
      <div class="space-y-1 px-2 pt-2 pb-3">
        <a v-for="item in navigation" :key="item.name" as="a" :href="item.href" :class="[
          item.current
            ? 'bg-gray-900 text-white'
            : 'text-gray-300 hover:bg-gray-700 hover:text-white',
          'block px-3 py-2 rounded-md text-base font-medium',
        ]" :aria-current="item.current ? 'page' : undefined">{{ item.name }}</a>
      </div>
    </DisclosurePanel>
  </Disclosure>
</template>

<script setup>
import { ref } from "vue";
import {
  Dialog,
  DialogPanel,
  DialogTitle,
  TransitionChild,
  TransitionRoot,
  Disclosure,
  DisclosureButton,
  DisclosurePanel,
  Menu,
  MenuButton,
  MenuItem,
  MenuItems,
} from "@headlessui/vue";
import {
  Bars3Icon,
  XMarkIcon,
  ShoppingCartIcon,
} from "@heroicons/vue/24/outline";
import { RouterLink } from "vue-router";

const navigation = [
  { name: "New", href: "/", current: true },
  { name: "Allseries", href: "/AllBook", current: false },
  { name: "Manga", href: "/Manga", current: false },
  { name: "Light novel", href: "/Novel", current: false },
];
const isOpen = ref(false);
</script>


<script>


export default {
  name: "MainNavbar",
  data() {
    return {
      
    }
  },
  props: {
    cart: Array,
    add: Function,
    remove: Function,
    totalPrice: Number,
    totalCart: Number,
  },
  components: { RouterLink },
  methods: {
    logout() {
      this.$store.commit("logout")
    }
  }
};
</script>
