from Bio import SeqIO
def get_contig_ids_from_kraken_output(kraken_output_file,target_id):
    contig_ids = []
    with open(kraken_output_file, 'r') as file:
        for line in file:
            columns = line.strip().split('\t')
            if len(columns) >= 2 and columns[2] == target_id:
                contig_ids.append(columns[1])
    return contig_ids
def extract_sequences_from_contig_file(contig_file, contig_ids, output_file):
    output_records = []
    with open(contig_file, 'r') as file:
        sequences = SeqIO.parse(file, "fasta")
        for sequence in sequences:
            sequence_id = sequence.id
            if sequence_id in contig_ids:  
                output_records.append(f">{sequence_id}\n")  
                output_records.append(f"{sequence.seq}\n")  
    with open(output_file, 'w') as file:
        file.writelines(output_records)
    return output_file 
# Đường dẫn đến file output của Kraken2
kraken_output_file = 'result/Assembly/Kraken2/kraken2_output'
# ID taxonomy cần tìm
target_id = '64293'
# Lấy các sequence ID có ID taxonomy là 64293 từ file output
contig_ids = get_contig_ids_from_kraken_output(kraken_output_file,target_id)
# Đường dẫn đến file FASTQ chứa các read
contig_file = 'result/Assembly/Spades/transcripts.fasta'

# Đường dẫn đến file output để lưu trữ các read tương ứng
output_file = 'result/Assembly/Kraken2/tembusu.fasta'

# Trích xuất các trình tự của các read tương ứng
extract_sequences_from_contig_file(contig_file,contig_ids,output_file)  