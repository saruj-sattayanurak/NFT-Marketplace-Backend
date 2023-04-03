require 'eth'

module Contract
    class Cli
        def initialize  
            @client = Eth::Client.create(Figaro.env.infura_link)
            @contract = Eth::Contract.from_abi(
                name: Figaro.env.contract_name,
                address: Eth::Address.new(Figaro.env.contract_address),
                abi: Figaro.env.contract_abi
            )
        end  
    
        def nft_data(id)
            artwork = Artwork.find(id)
            return unless artwork.present?

            image_url = @client.call(@contract, "tokenURI", id)
            
            response = HTTParty.get(image_url)
            raise("Can not get image url") unless response["image"].present?

            price = @client.call(@contract, "tokenPrice", id)

            {
                id: id,
                name: artwork.name,
                description: artwork.description,
                image_url: response["image"],
                price: price,
                status: artwork.status,
                foundation_name: artwork&.foundation&.name
            }
        end

        def mint(wallet, id, url, price)
            deployer_account = Eth::Key.new priv: Figaro.env.example_private_key
            deployer_account.address
            @client.transact_and_wait(@contract, "mint", wallet, id, url, price, sender_key: deployer_account, gas_limit: 200000)
        end

        def getOwner(id)
            @client.call(@contract, "ownerOf", id)
        end
    end
end
