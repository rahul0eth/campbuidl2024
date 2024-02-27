import * as React from "react";
import { useSendTransaction, useReadContract } from "wagmi";
import { parseEther } from "viem";

export function SendTransaction() {
  const { data: hash, sendTransaction, isPending } = useSendTransaction();

  async function submit(e: React.FormEvent<HTMLFormElement>) {
    e.preventDefault();
    const formData = new FormData(e.target as HTMLFormElement);
    const value = formData.get("value") as string;
    sendTransaction({
      to: "0xa2ae42a1b1977120ac4f24018becadcd4bcf7c09",
      value: parseEther(value),
    });
  }

  const NFT_ABI = [
    {
      inputs: [],
      name: "buy",
      outputs: [],
      stateMutability: "payable",
      type: "function",
    },
    {
      inputs: [
        {
          internalType: "string",
          name: "_trait",
          type: "string",
        },
      ],
      name: "mint",
      outputs: [],
      stateMutability: "nonpayable",
      type: "function",
    },
    {
      inputs: [
        {
          internalType: "address",
          name: "_to",
          type: "address",
        },
        {
          internalType: "uint256",
          name: "_id",
          type: "uint256",
        },
      ],
      name: "transfer",
      outputs: [],
      stateMutability: "nonpayable",
      type: "function",
    },
    {
      inputs: [],
      stateMutability: "nonpayable",
      type: "constructor",
    },
    {
      inputs: [
        {
          internalType: "uint256",
          name: "_id",
          type: "uint256",
        },
      ],
      name: "getTraits",
      outputs: [
        {
          internalType: "string",
          name: "",
          type: "string",
        },
      ],
      stateMutability: "view",
      type: "function",
    },
    {
      inputs: [
        {
          internalType: "uint256",
          name: "_id",
          type: "uint256",
        },
      ],
      name: "ownerOf",
      outputs: [
        {
          internalType: "address",
          name: "",
          type: "address",
        },
      ],
      stateMutability: "view",
      type: "function",
    },
  ];

  const contractConfig = {
    address: "0xe2ea6d3c1dd9c42a3f6c97f80bd865e45369832e" as `0x${string}`,
    abi: NFT_ABI,
  };

  const { data: ownerOf } = useReadContract({
    ...contractConfig,
    functionName: "ownerOf",
    args: [0],
  });

  return <div>Owner of ID 0: {ownerOf?.toString()}</div>;

  return (
    <form
      onSubmit={submit}
      className="flex flex-col items-center justify-center space-y-4"
    >
      <h1 className="text-2xl font-bold">Buy me a coffee!</h1>
      <input
        name="value"
        placeholder="0.05 ETH"
        required
        className="p-2 border border-gray-300 rounded"
      />
      <button
        type="submit"
        disabled={isPending}
        className="p-2 text-white rounded disabled:bg-gray-400 disabled:cursor-not-allowed bg-purple w-100"
      >
        {isPending ? "Confirming..." : "Donate"}
      </button>
      {hash && <div className="text-gray-500">Transaction Hash: {hash}</div>}
    </form>
  );

  // return (
  //   <form onSubmit={submit} className="flex flex-col items-center justify-center space-y-4">
  //     <h1 className="text-2xl font-bold">Buy me a coffee!</h1>
  //     <input name="value" placeholder="0.05 ETH" required className="p-2 border border-gray-300 rounded" />
  //     <button type="submit" disabled={isPending} className="p-2 text-white rounded disabled:bg-gray-400 disabled:cursor-not-allowed bg-purple w-100">
  //       {isPending ? 'Confirming...' : 'Donate'}
  //     </button>
  //     {hash && <div className="text-gray-500">Transaction Hash: {hash}</div>}
  //   </form>
  // )
}
