import React, { useState } from "react";
import { NativeBaseProvider, Box, Input, Button, Text, VStack, HStack, Divider } from "native-base";

export default function App() {
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");

  const handleLogin = () => {
    alert(`帳號：${username}\n密碼：${password}`);
  };

  return (
    <NativeBaseProvider>
      <Box flex={1} bg="#D9C7C7" justifyContent="center" alignItems="center">
        <Box bg="white" px={8} py={10} rounded="lg" width="80%">
          <Text fontSize="3xl" textAlign="center" mb={4} fontFamily="cursive">Login</Text>
          <Divider mb={6} />

          <VStack space={4}>
            <Box>
              <Text mb={1} fontFamily="cursive">Username :</Text>
              <Input
                bg="#EAF5ED"
                value={username}
                onChangeText={setUsername}
                placeholder="Enter username"
              />
            </Box>

            <Box>
              <Text mb={1} fontFamily="cursive">Password :</Text>
              <Input
                bg="#EAF5ED"
                value={password}
                onChangeText={setPassword}
                placeholder="Enter password"
                type="password"
              />
            </Box>

            <HStack justifyContent="space-between" alignItems="center" mt={4}>
              <Button bg="#CFE6D4" _text={{ color: "black", fontFamily: "cursive" }} onPress={handleLogin}>
                sign in
              </Button>
              <Text underline fontFamily="cursive">qr code ?</Text>
            </HStack>
          </VStack>
        </Box>
      </Box>
    </NativeBaseProvider>
  );
}
